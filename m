Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942614900E
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494131; cv=none; b=GDRb7Zw2ancDZx5g1AlsqRMeMUZEBPo4Rxz/bGkioUiZb4hlZ46bwfz9MhUuPdA3qHvg25NiVeDxo8wjJdzRy2PGsf7UqOMyLIWnLLddUNtUgYZqGulzOj6oMGDmapZEw8ZniLD+q8mqGxITinsCRmMiNp7h5aQBh5FTHeaMJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494131; c=relaxed/simple;
	bh=w6jIi38Q/dUmnLWT1E99iifrmAAayePDRGLwuQmIXZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJzTp+t8z/rVgDdcwzoTvQ7VGCblUDZW+uSj0W6k0+Vy9yh9sUB64aI9OeSFQhB2RszBIo6J8rMe9bliEwY/ePqDI1gXlc1aKJYXDTxM7hEblsONxeNXLLYOYSAGqlpJGKanN8xYVAm1ap71qOrKbVOS2r3hza7MgMD+W8tSRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0ad6bb48ba4511f19a56ed5b684f684d-20260927
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8a7deb06-d4bc-4c41-bef8-37ea0f95f791,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:8a7deb06-d4bc-4c41-bef8-37ea0f95f791,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:097ba7729f98d559a1a08277f70a3465,BulkI
	D:260927151408ZWAW9HXW,BulkQuantity:2,SF:17|19|38|66|78|102|127|865|898,TC
	:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ad6bb48ba4511f19a56ed5b684f684d-20260927
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(111.193.136.161)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1466070180; Sun, 27 Sep 2026 15:28:32 +0800
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
Subject: [RFC PATCH 0/4] rust: damon: a first small step, plus a Rust prcl sample
Date: Sun, 27 Sep 2026 15:28:08 +0800
Message-ID: <20260927072812.2393456-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ, hi all,

Almost a year ago, right after a memory-leak fix discussion on this list, I
asked whether introducing Rust for some DAMON modules could be worth
exploring as a proactive measure.  SJ's answer was positive: he was open to
Rust adoption in DAMON, both in kernel and user space, and even mentioned
he had been wanting to write a Rust sample DAMON module himself since LPC,
but had not found the time yet [1].

So, here is my attempt at making that start happen.  This RFC is
intentionally small: it adds just enough Rust support for DAMON to port the
proactive reclamation sample (prcl.c), and nothing more.

The series has four patches:

  1. Generate Rust bindings for include/linux/damon.h.
  2. Add thin safe wrappers in a new rust::kernel::damon module: contexts,
     targets, access patterns, quotas, watermarks, schemes, plus
     start/stop.  Everything FFI-related is confined to the wrappers, with
     the usual SAFETY comments; error codes are returned as kernel::Result.
  3. Add samples/damon/rust_prcl.rs, a Rust port of prcl.c.  It watches the
     virtual address space of a target process and pages out cold regions
     with the DAMOS_PAGEOUT action, same access-pattern filter as the C
     version.
  4. Add a MAINTAINERS entry for the two new files.

Two differences from the C sample are worth noting.

First, the control interface.  The C prcl sample is driven through
runtime-writable module parameters (target_pid and enabled, the latter via
module_param_cb), neither of which Rust can express yet -- its module
parameters are load-time only and do not show up under /sys/module/, and
there is no general sysfs abstraction in mainline or the RfL rust-next
tree.  The debugfs abstraction, however, already provides the safe
read/write wrappers we need, so the Rust sample exposes the same two knobs
under /sys/kernel/debug/rust_prcl/.  This is a temporary detour, not a
design preference: the sample will be switched over to match the C
interface once Rust supports sysfs-backed module parameters.

Second, the functional scope.  The C sample also repeatedly reports the
estimated working set size via a repeating damon_call() callback.  This
initial Rust version covers only the core monitoring/reclamation path
(context, target, PAGEOUT scheme, start/stop); wss reporting needs safe
wrappers for damon_call() and region iteration, which will come in a
follow-up series that also makes the Rust sample's output match the C
one's.

A quick word on the longer-term plan, so the design discussion here can
happen with the destination in mind:

  - Over roughly the next year, I would like to port the other two DAMON
    samples (wsse and mtier) to Rust as well, and let the DAMON Rust
    compatibility layer grow together with them, wrapping only what real
    in-tree users need.
  - Once that layer has matured, I would be happy to try Rust for the
    production modules - damon/reclaim, damon/lru_sort and damon/stat.
    That is a much bigger step, of course, and it only happens if SJ is
    comfortable with it.  Consider it a willingness statement, not a
    promise.

Regarding the MAINTAINERS patch: I listed myself for the new files, but did
not add SJ as a reviewer yet, since he mentioned limited bandwidth for Rust
work in that earlier discussion.  The existing DAMON entry already covers
samples/damon/, so the sample reaches him regardless; adding him to the
RUST [DAMON] entry would only additionally route future changes to
rust/kernel/damon.rs his way.  Happy to add the R: line if he wants it, or
leave it out if he prefers.

Testing: build test kernel with CONFIG_RUST=y and
CONFIG_SAMPLE_DAMON_RUST_PRCL=y.  Functionally exercised via debugfs:

  # echo <pid> > /sys/kernel/debug/rust_prcl/target_pid
  # echo y > /sys/kernel/debug/rust_prcl/enabled
  ... cold regions of the target get paged out ...
  # echo n > /sys/kernel/debug/rust_prcl/enabled

This is an RFC, so comments on the wrapper API shape, naming and the
debugfs detour are especially welcome.

[1] https://lore.kernel.org/all/20251015150701.68087-1-sj@kernel.org/

Enze Li (4):
  rust: add bindings for linux/damon.h
  rust: damon: add basic DAMON abstractions
  samples/damon: add Rust sample for DAMON access-aware proactive reclamation
  MAINTAINERS: add entry for the DAMON Rust abstractions

 MAINTAINERS                     |   8 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/damon.rs            | 292 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 samples/Makefile                |   1 +
 samples/damon/Kconfig           |  12 ++
 samples/damon/Makefile          |   1 +
 samples/damon/rust_prcl.rs      | 158 +++++++++++++++++
 8 files changed, 475 insertions(+)
 create mode 100644 rust/kernel/damon.rs
 create mode 100644 samples/damon/rust_prcl.rs

-- 
2.25.1

