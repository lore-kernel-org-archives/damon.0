Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20A332EC8
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494132; cv=none; b=btGOXsea+EhU5baXzjp6Sd9MA57Gb8C8p3c0RpPnYPVqL1kN7z6uiIhPaeLbUrHEs5AOC8SFyCk/rCOkWgEK8+t0TMe4xdwTHBdqcCk55av2do32yK8M6Y/6HYUJ2ZBu3jta+jWek6O7YxMLFIKbd99ZXHZUMllWSxoSL98LwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494132; c=relaxed/simple;
	bh=wIOasHaN1EoDpuPv1qqVy+HfcR0pU+uziJTPVbK5E1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMmFsyRHSZVoLtf3yungNPYhQmafx0lLZ3SItALJCvl60wqVPXqGK08FMrF3Mv5JnsB347rshXWC+doarG4DRj2k+09ec8eEjxQpV0eE2txLgiFWRRk3xS1brVd79LF4ssLTwR8R6NeZOWb8ePbtNVPHLHrJaYZnRG4Jw/qlG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c23f236ba4511f19a56ed5b684f684d-20260927
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
X-CID-O-INFO: VERSION:1.3.19,REQID:2660ce27-5538-4d3c-845d-208cdce73c04,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.19,REQID:2660ce27-5538-4d3c-845d-208cdce73c04,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:7db8b62,CLOUDID:02d83635f4541371c5115f0d53ea8629,BulkI
	D:260927151417B1NOXWS8,BulkQuantity:2,SF:17|19|38|66|78|81|82|102|127|865|
	898,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c23f236ba4511f19a56ed5b684f684d-20260927
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(111.193.136.161)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1652417392; Sun, 27 Sep 2026 15:28:34 +0800
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
Subject: [RFC PATCH 3/4] samples/damon: add Rust sample for DAMON access-aware proactive reclamation
Date: Sun, 27 Sep 2026 15:28:11 +0800
Message-ID: <20260927072812.2393456-4-lienze@kylinos.cn>
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

Add a Rust implementation of the DAMON-based proactive reclamation sample
module, porting the logic from prcl.c to demonstrate using Rust bindings
for DAMON C APIs.

The module monitors the virtual address space of a target process via DAMON
vaddr operations and proactively reclaims cold memory regions using the
DAMOS_PAGEOUT action with an access pattern filter.

Unlike the C version (prcl.c), which is configured through module
parameters, the Rust version provides debugfs-based runtime control under
/sys/kernel/debug/rust_prcl/.  Monitoring can be enabled or disabled by
writing to the enabled file, while the target process to monitor is
selected by writing its PID to target_pid.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 samples/Makefile           |   1 +
 samples/damon/Kconfig      |  12 +++
 samples/damon/Makefile     |   1 +
 samples/damon/rust_prcl.rs | 158 +++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 samples/damon/rust_prcl.rs

diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8..df726c0653cd 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -43,5 +43,6 @@ obj-$(CONFIG_SAMPLES_RUST)		+= rust/
 obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_MTIER)	+= damon/
+obj-$(CONFIG_SAMPLE_DAMON_RUST_PRCL)	+= damon/
 obj-$(CONFIG_SAMPLE_HUNG_TASK)		+= hung_task/
 obj-$(CONFIG_SAMPLE_TSM_MR)		+= tsm-mr/
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index 00be3e6bdd65..654b62e186c9 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -40,4 +40,16 @@ config SAMPLE_DAMON_MTIER
 
 	  If unsure, say N.
 
+config SAMPLE_DAMON_RUST_PRCL
+	bool "Rust sample module for DAMON-based access-aware proactive reclamation"
+	depends on DAMON && DAMON_VADDR && RUST && DEBUG_FS
+	help
+	  This option builds the Rust implementation of DAMON-based prcl sample.
+
+	  The module exposes two debugfs interfaces under
+	  /sys/kernel/debug/rust_prcl/ for starting/stopping monitoring
+	  and setting the target PID.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
index 72f68cbf422a..2e3ed8d9dd5d 100644
--- a/samples/damon/Makefile
+++ b/samples/damon/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
 obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
 obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
+obj-$(CONFIG_SAMPLE_DAMON_RUST_PRCL) += rust_prcl.o
diff --git a/samples/damon/rust_prcl.rs b/samples/damon/rust_prcl.rs
new file mode 100644
index 000000000000..1e6c820311e2
--- /dev/null
+++ b/samples/damon/rust_prcl.rs
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust prcl sample.
+
+use core::ptr::null_mut;
+use kernel::bindings;
+use kernel::damon;
+use kernel::debugfs::Scope;
+use kernel::prelude::*;
+use kernel::sync::atomic::{Atomic, Relaxed};
+use kernel::uaccess::UserSliceReader;
+
+module! {
+    type: RustPrcl,
+    name: "rust_prcl",
+    authors: ["Enze Li <lienze@kylinos.cn>"],
+    description: "DAMON-based proactive reclamation module for rust edition",
+    license: "GPL",
+}
+
+struct RustPrcl {
+    _data: Pin<KBox<Scope<ModuleData>>>,
+}
+
+struct ModuleData {
+    enabled: Atomic<bool>,
+    target_pid: Atomic<i32>,
+}
+
+impl Drop for ModuleData {
+    fn drop(&mut self) {
+        if self.enabled.load(Relaxed) {
+            damon_sample_rust_prcl_stop();
+        }
+    }
+}
+
+static CTX: Atomic<*mut bindings::damon_ctx> = Atomic::new(null_mut());
+
+fn damon_sample_rust_prcl_start(target_pid: i32) -> Result {
+    let ctx = damon::DamonCtx::damon_new_ctx()?;
+    ctx.damon_select_ops(damon::OpsID::VADDR)?;
+
+    let mut target = damon::Target::damon_new_target()?;
+    target.damon_set_target_pid(target_pid)?;
+    ctx.damon_add_target(target);
+
+    let mut pattern =
+        damon::DamosAccessPattern::new(bindings::PAGE_SIZE, usize::MAX, 0, 0, 50, u32::MAX);
+
+    let mut quota = damon::DamosQuota::zeroed();
+    let mut watermarks = damon::DamosWatermarks::zeroed();
+    let scheme = damon::Damos::new(
+        &mut pattern,
+        damon::DamosAction::PAGEOUT,
+        0,
+        &mut quota,
+        &mut watermarks,
+        bindings::NUMA_NO_NODE,
+    )?;
+
+    ctx.damon_add_scheme(scheme);
+
+    let ret = ctx.damon_start();
+    match ret {
+        Ok(_) => {
+            CTX.store(ctx.into_raw(), Relaxed);
+        }
+        Err(e) => {
+            pr_err!("damon_start failed, error: {:?}\n", e);
+            return Err(e);
+        }
+    }
+    Ok(())
+}
+
+fn damon_sample_rust_prcl_stop() {
+    pr_info!("stop\n");
+    let raw = CTX.xchg(null_mut(), Relaxed);
+    if !raw.is_null() {
+        // SAFETY: raw came from into_raw() at damon_start(), and xchg()
+        // makes its sole remaining owner, so moving it back once is safe.
+        let _ctx = unsafe { damon::DamonCtx::from_raw(raw) };
+        // _ctx drops at the end of this scope, it runs damon_stop(1) and
+        // damon_destroy_ctx().
+    }
+}
+
+fn damon_sample_rust_parse_bool(s: &str) -> Result<bool> {
+    let s = s.trim();
+    if s.eq_ignore_ascii_case("y") {
+        Ok(true)
+    } else if s.eq_ignore_ascii_case("n") {
+        Ok(false)
+    } else {
+        Err(EINVAL)
+    }
+}
+
+fn enabled_read(data: &ModuleData, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
+    writeln!(f, "{}", if data.enabled.load(Relaxed) { 'Y' } else { 'N' })
+}
+
+fn enabled_write(data: &ModuleData, reader: &mut UserSliceReader) -> Result {
+    let mut buf = [0u8; 32];
+    if reader.len() > buf.len() {
+        return Err(EINVAL);
+    }
+    let n = reader.len();
+    reader.read_slice(&mut buf[..n])?;
+
+    let s = core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?;
+    let enabled = damon_sample_rust_parse_bool(s)?;
+
+    let is_enabled = data.enabled.load(Relaxed);
+    if enabled == is_enabled {
+        return Ok(());
+    }
+
+    if !damon::damon_initialized() {
+        return Ok(());
+    }
+
+    data.enabled.store(enabled, Relaxed);
+
+    if enabled {
+        let target_pid = data.target_pid.load(Relaxed);
+        if let Err(e) = damon_sample_rust_prcl_start(target_pid) {
+            data.enabled.store(false, Relaxed);
+            return Err(e);
+        }
+    } else {
+        damon_sample_rust_prcl_stop();
+    }
+
+    Ok(())
+}
+
+impl kernel::Module for RustPrcl {
+    fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
+        let data = KBox::pin_init(
+            Scope::dir(
+                ModuleData {
+                    enabled: Atomic::new(false),
+                    target_pid: Atomic::new(0),
+                },
+                c"rust_prcl",
+                |data, dir| {
+                    dir.read_write_callback_file(c"enabled", data, &enabled_read, &enabled_write);
+                    dir.read_write_file(c"target_pid", &data.target_pid);
+                },
+            ),
+            GFP_KERNEL,
+        )?;
+
+        Ok(Self { _data: data })
+    }
+}
-- 
2.43.0

