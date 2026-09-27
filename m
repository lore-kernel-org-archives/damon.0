Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52C379960
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494132; cv=none; b=gJQ1NzTbTODfEbmCBqqTwFTrEu125E4zaUHjRa5SUxW/YWrPtkVRfuptkKcY5z7k0ybrieQ+0g60gZrnLCBhCEVu/PLysIuDbxlmkH9cuZxxPWWW48BZeB0F0Tr/bXjr+yqcC4is4yX2Uqx7pqkkzEAgY7qu9v3aZn07e3Y+6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494132; c=relaxed/simple;
	bh=e6w8wGvMwguc8WHgwCIRlyJmxuqtAoR8V3/G2agHBOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWUUHJxyiDemdIFSHuY+J835qrSLbvd7llBotkna/6l6vpoIIGcdW8YGQTwnFTcm4yIc1X/hadzCBkHrr1ZfbffG04yu33Q3FzgGoXznXA7480Mouwau1Pi4f+tQW1oW3pwa93dlmfcWnGmHUmQXKzXfp5Y7BsiptY+BrEPwKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0bc9624eba4511f19a56ed5b684f684d-20260927
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c184b21c-b33d-49c6-a839-58846766de1f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:c184b21c-b33d-49c6-a839-58846766de1f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:5a4e9d38c54021276dcf671fdffcefca,BulkI
	D:2609271514145MNY4Q9T,BulkQuantity:2,SF:17|19|38|66|78|81|82|102|127|865|
	898,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0bc9624eba4511f19a56ed5b684f684d-20260927
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(111.193.136.161)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1329889295; Sun, 27 Sep 2026 15:28:33 +0800
From: Enze Li <lienze@kylinos.cn>
To: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	sj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	lienze@kylinos.cn
Subject: [RFC PATCH 2/4] rust: damon: add basic DAMON abstractions
Date: Sun, 27 Sep 2026 15:28:10 +0800
Message-ID: <20260927072812.2393456-3-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927072812.2393456-1-lienze@kylinos.cn>
References: <20260927072812.2393456-1-lienze@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap the basic DAMON C API in a new rust/kernel/damon module, exposing
contexts, targets, schemes, and the types that configure them, so Rust
modules can drive DAMON without calling the raw C functions directly.

This initial support will then be used by a subsequent sample module.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 rust/kernel/damon.rs | 292 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   2 +
 2 files changed, 294 insertions(+)
 create mode 100644 rust/kernel/damon.rs

diff --git a/rust/kernel/damon.rs b/rust/kernel/damon.rs
new file mode 100644
index 000000000000..80e6609132e7
--- /dev/null
+++ b/rust/kernel/damon.rs
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 KylinSoft Corporation.
+// Author: Enze Li <lienze@kylinos.cn>
+
+//! DAMON (Data Access MONitor) abstractions.
+//!
+//! C header: [`include/linux/damon.h`](srctree/include/linux/damon.h)
+
+use core::ptr::NonNull;
+
+use kernel::bindings;
+use kernel::error::code::*;
+use kernel::error::Error;
+use kernel::error::Result;
+
+/// Return if DAMON is ready to be used.
+pub fn damon_initialized() -> bool {
+    // SAFETY: It is a simple pure query function.
+    unsafe { bindings::damon_initialized() }
+}
+
+/// DAMON operations.
+pub struct OpsID {
+    ops_id: bindings::damon_ops_id,
+}
+
+impl OpsID {
+    /// Monitoring operations for virtual address spaces.
+    pub const VADDR: Self = Self {
+        ops_id: bindings::damon_ops_id_DAMON_OPS_VADDR,
+    };
+}
+
+/// Represents a monitoring target.
+pub struct Target {
+    target: NonNull<bindings::damon_target>,
+}
+
+impl Target {
+    /// Construct a damon_target struct.
+    pub fn damon_new_target() -> Result<Self> {
+        // SAFETY: damon_new_target returns a valid pointer to new allocated
+        // damon_target or NULL if allocation failure, which will be checked
+        // by the subsequent NonNull::new.
+        let raw = unsafe { bindings::damon_new_target() };
+        let t = NonNull::new(raw).ok_or(ENOMEM)?;
+        Ok(Self { target: t })
+    }
+
+    /// Set the PID of monitoring target.
+    pub fn damon_set_target_pid(&mut self, pid: i32) -> Result {
+        // SAFETY: slef.target is a valid, non-null 'damon_target *' by the
+        // Target invariant, and the '&mut self' borrow keeps it alive for
+        // the duration of the call.  The returned errno is checked below.
+        let ret = unsafe { bindings::damon_set_target_pid(self.target.as_ptr(), pid) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+}
+
+impl Drop for Target {
+    fn drop(&mut self) {
+        let t = self.target.as_ptr();
+
+        // SAFETY: t is a valid, non-null 'damon_target *' by the Target
+        // invariant, and release the pid refcount taken by find_get_pid
+        // with a matching put_pid, then free the target once in Drop.
+        unsafe {
+            if !(*t).pid.is_null() {
+                bindings::put_pid((*t).pid);
+            }
+            bindings::damon_free_target(t)
+        };
+    }
+}
+
+/// Target access pattern of the given scheme.
+pub struct DamosAccessPattern {
+    damos_access_pattern: bindings::damos_access_pattern,
+}
+
+impl DamosAccessPattern {
+    /// Create a new damos_access_pattern.
+    pub const fn new(
+        min_sz_region: usize,
+        max_sz_region: usize,
+        min_nr_accesses: u32,
+        max_nr_accesses: u32,
+        min_age_region: u32,
+        max_age_region: u32,
+    ) -> Self {
+        Self {
+            damos_access_pattern: bindings::damos_access_pattern {
+                min_sz_region,
+                max_sz_region,
+                min_nr_accesses,
+                max_nr_accesses,
+                min_age_region,
+                max_age_region,
+            },
+        }
+    }
+}
+
+/// Controls the aggressiveness of the given scheme.
+pub struct DamosQuota {
+    damos_quota: bindings::damos_quota,
+}
+
+impl DamosQuota {
+    /// Create a zero-initialized damos_quota sturct.
+    pub fn zeroed() -> Self {
+        Self {
+            // SAFETY: All-zero is a valid bit pattern for damos_quota.
+            damos_quota: unsafe { core::mem::zeroed() },
+        }
+    }
+}
+
+/// Controls when a given scheme should be activated.
+pub struct DamosWatermarks {
+    damos_watermarks: bindings::damos_watermarks,
+}
+
+impl DamosWatermarks {
+    /// Create a zero-initialized damos_watermarks sturct.
+    pub fn zeroed() -> Self {
+        Self {
+            // SAFETY: All-zero is a valid bit pattern for damos_watermarks.
+            damos_watermarks: unsafe { core::mem::zeroed() },
+        }
+    }
+}
+
+/// Represents an action of a Data Access Monitoring-based Operation Scheme.
+pub struct DamosAction {
+    /// Reclaim the region.
+    damos_action: bindings::damos_action,
+}
+
+impl DamosAction {
+    /// PAGEOUT action.
+    pub const PAGEOUT: Self = Self {
+        damos_action: bindings::damos_action_DAMOS_PAGEOUT,
+    };
+}
+
+/// Represents a Data Access Monitoring-based Operation Scheme.
+pub struct Damos {
+    damos: NonNull<bindings::damos>,
+}
+
+impl Damos {
+    /// Create new Damos.
+    pub fn new(
+        pattern: &mut DamosAccessPattern,
+        action: DamosAction,
+        apply_interval_us: usize,
+        quota: &mut DamosQuota,
+        wmarks: &mut DamosWatermarks,
+        target_nid: i32,
+    ) -> Result<Self> {
+        // SAFETY: All pointer arguments come from local variables that
+        // stay alive during the call; the rest are just numbers.  The
+        // return value is checked for NULL right after.
+        let ptr = unsafe {
+            bindings::damon_new_scheme(
+                &mut pattern.damos_access_pattern,
+                action.damos_action,
+                apply_interval_us,
+                &mut quota.damos_quota,
+                &mut wmarks.damos_watermarks,
+                target_nid,
+            )
+        };
+        NonNull::new(ptr).map(|p| Self { damos: p }).ok_or(ENOMEM)
+    }
+}
+
+/// DAMON monitoring context.
+pub struct DamonCtx {
+    ctx: NonNull<bindings::damon_ctx>,
+}
+
+impl DamonCtx {
+    /// Create a new DAMON monitoring context.
+    pub fn damon_new_ctx() -> Result<Self> {
+        // SAFETY: damon_new_ctx returns a valid pointer to new allocated
+        // damon_ctx or NULL if allocation failure, which will be checked
+        // by the subsequent NonNull::new.
+        let raw = unsafe { bindings::damon_new_ctx() };
+        let c = NonNull::new(raw).ok_or(ENOMEM)?;
+        Ok(Self { ctx: c })
+    }
+
+    /// Select a monitoring operations to use with the context.
+    pub fn damon_select_ops(&self, id: OpsID) -> Result {
+        // SAFETY: self.ctx was created by a successful damon_new_ctx()
+        // call, so it points to a valid damon_ctx. id.ops_id comes from a
+        // known-good constant, so it is a value the C side understands.
+        let ret = unsafe { bindings::damon_select_ops(self.ctx.as_ptr(), id.ops_id) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Add a new DAMON monitoring target.
+    pub fn damon_add_target(&self, target: Target) {
+        // SAFETY: Both arguments are valid: self.ctx is non-null by
+        // construction, and target.target points to an unique owned
+        // damon_target.  The C function takes ownership of the target
+        // that is why rust slide should forget it.
+        unsafe { bindings::damon_add_target(self.ctx.as_ptr(), target.target.as_ptr()) };
+        core::mem::forget(target);
+    }
+
+    /// Add a scheme to context.
+    pub fn damon_add_scheme(&self, scheme: Damos) {
+        // SAFETY: self.ctx is a valid 'damon_ctx *' and scheme.damos is a
+        // valid 'damos *', both by the type invariants of Ctx and Damos.
+        // damon_add_scheme takes ownership of the scheme, so the rust
+        // side should forget it to avoid a double free.
+        unsafe { bindings::damon_add_scheme(self.ctx.as_ptr(), scheme.damos.as_ptr()) };
+        core::mem::forget(scheme);
+    }
+
+    /// Starts the monitorings for a given group of contexts.
+    pub fn damon_start(&self) -> Result {
+        let mut ctxs = [self.ctx.as_ptr()];
+        // SAFETY: ctxs is a stack-allocated array of length 1 whose only
+        // element is a valid 'damon_ctx *'.  The pointer remains valid
+        // for the duration of the call.  The length argument 1 matches the
+        // array size, and true is a valid bool value for the exclusive
+        // parameter.
+        let ret = unsafe { bindings::damon_start(ctxs.as_mut_ptr(), 1, true) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Transfers ownership of the underlying damon_ctx to the caller.
+    /// After this call, the DamonCtx is consumed and will not call
+    /// damon_destroy_ctx on drop.  The caller becomes responsible for
+    /// eventually calling damon_destroy_ctx.
+    pub fn into_raw(self) -> *mut bindings::damon_ctx {
+        let ptr = self.ctx.as_ptr();
+        core::mem::forget(self);
+        ptr
+    }
+
+    /// Reconstructs a DamonCtx from a raw pointer returned by into_raw.
+    /// Note that the ptr must be the non-null pointer obtained from
+    /// into_raw(), and returned once -- the caller must not use ptr
+    /// afterwards, and no other owner may remain.
+    pub unsafe fn from_raw(ptr: *mut bindings::damon_ctx) -> Self {
+        // SAFETY: ptr is a valid, non-null 'damon_ctx *'.
+        Self {
+            ctx: unsafe { NonNull::new_unchecked(ptr) },
+        }
+    }
+
+    /// Stops the monitorings for a given group of contexts.
+    fn damon_stop(&self, nr_ctxs: i32) {
+        let mut ctxs = [self.ctx.as_ptr()];
+        // SAFETY: ctxs is a stack buffer whose element is a valid
+        // 'damon_ctx *' by the DamonCtx invariant.
+        unsafe { bindings::damon_stop(ctxs.as_mut_ptr(), nr_ctxs) };
+    }
+
+    /// Destroys the contexts and frees all associated resources.
+    fn damon_destroy_ctx(&self) {
+        // SAFETY: self.ctx is a valid, non-null 'damon_ctx *' by the
+        // DamonCtx invariant, and it is only destroyed once from drop()
+        // that execute after damon_stop().
+        unsafe { bindings::damon_destroy_ctx(self.ctx.as_ptr()) };
+    }
+}
+
+impl Drop for DamonCtx {
+    fn drop(&mut self) {
+        self.damon_stop(1);
+        self.damon_destroy_ctx();
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 4d5c96ddc49c..7e9e748cd0b9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -62,6 +62,8 @@
 pub mod cpufreq;
 pub mod cpumask;
 pub mod cred;
+#[cfg(CONFIG_DAMON)]
+pub mod damon;
 pub mod debugfs;
 pub mod device;
 pub mod device_id;
-- 
2.43.0

