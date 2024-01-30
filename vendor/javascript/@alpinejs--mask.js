function src_default(e){e.directive("mask",((t,{value:l,expression:n},{effect:r,evaluateLater:s,cleanup:i})=>{let templateFn=()=>n;let u="";queueMicrotask((()=>{if(["function","dynamic"].includes(l)){let l=s(n);r((()=>{templateFn=n=>{let r;e.dontAutoEvaluateFunctions((()=>{l((e=>{r=typeof e==="function"?e(n):e}),{scope:{$input:n,$money:formatMoney.bind({el:t})}})}));return r};processInputValue(t,false)}))}else processInputValue(t,false);t._x_model&&t._x_model.set(t.value)}));const a=new AbortController;i((()=>{a.abort()}));t.addEventListener("input",(()=>processInputValue(t)),{signal:a.signal,capture:true});t.addEventListener("blur",(()=>processInputValue(t,false)),{signal:a.signal});function processInputValue(e,t=true){let l=e.value;let n=templateFn(l);if(!n||n==="false")return false;if(u.length-e.value.length===1)return u=e.value;let setInput=()=>{u=e.value=formatInput(l,n)};t?restoreCursorPosition(e,n,(()=>{setInput()})):setInput()}function formatInput(e,t){if(e==="")return"";let l=stripDown(t,e);let n=buildUp(t,l);return n}})).before("model")}function restoreCursorPosition(e,t,l){let n=e.selectionStart;let r=e.value;l();let s=r.slice(0,n);let i=buildUp(t,stripDown(t,s)).length;e.setSelectionRange(i,i)}function stripDown(e,t){let l=t;let n="";let r={9:/[0-9]/,a:/[a-zA-Z]/,"*":/[a-zA-Z0-9]/};let s="";for(let t=0;t<e.length;t++)if(["9","a","*"].includes(e[t]))s+=e[t];else for(let n=0;n<l.length;n++)if(l[n]===e[t]){l=l.slice(0,n)+l.slice(n+1);break}for(let e=0;e<s.length;e++){let t=false;for(let i=0;i<l.length;i++)if(r[s[e]].test(l[i])){n+=l[i];l=l.slice(0,i)+l.slice(i+1);t=true;break}if(!t)break}return n}function buildUp(e,t){let l=Array.from(t);let n="";for(let t=0;t<e.length;t++)if(["9","a","*"].includes(e[t])){if(l.length===0)break;n+=l.shift()}else n+=e[t];return n}function formatMoney(e,t=".",l,n=2){if(e==="-")return"-";if(/^\D+$/.test(e))return"9";l!==null&&l!==void 0||(l=t===","?".":",");let addThousands=(e,t)=>{let l="";let n=0;for(let r=e.length-1;r>=0;r--)if(e[r]!==t){if(n===3){l=e[r]+t+l;n=0}else l=e[r]+l;n++}return l};let r=e.startsWith("-")?"-":"";let s=e.replaceAll(new RegExp(`[^0-9\\${t}]`,"g"),"");let i=Array.from({length:s.split(t)[0].length}).fill("9").join("");i=`${r}${addThousands(i,l)}`;n>0&&e.includes(t)&&(i+=`${t}`+"9".repeat(n));queueMicrotask((()=>{this.el.value.endsWith(t)||this.el.value[this.el.selectionStart-1]===t&&this.el.setSelectionRange(this.el.selectionStart-1,this.el.selectionStart-1)}));return i}var e=src_default;export{e as default,src_default as mask,stripDown};

