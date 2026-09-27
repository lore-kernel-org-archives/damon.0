Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722D3BBFA9
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790494134; cv=none; b=ceWjy4vMEFOz1M0QxWY5ZAYQfsvhUCGvsAWQEjZE6rlwBoIFbKY0PhfV49I9ZZHf4LaDYwet0c8/UsodXECHkoNPAExkhM6LjdrXc2aNwRUpi5foPzWN6pIZQ3nWilIOe1AiEHpzOKhKB9aQGs5XenhaPNDxCgWY0ykoTSOvV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790494134; c=relaxed/simple;
	bh=T2NJq2dvg97JgHhfyjgSUPeesn6H/l+I8XyYVFV0Gw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvvSCsFKiCgO6yVGnKsY8Co0otu1oM1LR/j44E4KQUPs49ONG7Nrtkn5gaSOYfQSW9ABqJSPZvXp57Ps6lxGqqIup2i+ZFhd9KAWLfT455VgXf5YO12Xgq7aewtqbqVANnHWf8P8haDpaPKsEjQkK74LCf1eQJMrL7iCSLNf5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c7a6684ba4511f19a56ed5b684f684d-20260927
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
X-CID-O-INFO: VERSION:1.3.19,REQID:6cf48ef6-ddd9-416a-b059-825af14198b4,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.19,REQID:6cf48ef6-ddd9-416a-b059-825af14198b4,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:7db8b62,CLOUDID:12b878dd324cbc016a0191149a79bcb8,BulkI
	D:260927152838M6OXUQWH,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|865|
	898,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c7a6684ba4511f19a56ed5b684f684d-20260927
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(111.193.136.161)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1191654343; Sun, 27 Sep 2026 15:28:35 +0800
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
Subject: [RFC PATCH 4/4] MAINTAINERS: add entry for the DAMON Rust abstractions
Date: Sun, 27 Sep 2026 15:28:12 +0800
Message-ID: <20260927072812.2393456-5-lienze@kylinos.cn>
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

Add a RUST [DAMON] entry covering rust/kernel/damon.rs and
samples/damon/rust_prcl.rs so those files are maintained by Enze Li and
routed to the rust-for-linux and DAMON lists.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc1cb1d1c49..37136171f08d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24007,6 +24007,14 @@ L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 F:	rust/kernel/bitfield.rs
 
+RUST [DAMON]
+M:	Enze Li <lienze@kylinos.cn>
+L:	rust-for-linux@vger.kernel.org
+L:	damon@lists.linux.dev
+S:	Maintained
+F:	rust/kernel/damon.rs
+F:	samples/damon/rust_prcl.rs
+
 RUST [INTEROP]
 M:	Joel Fernandes <joelagnelf@nvidia.com>
 M:	Alexandre Courbot <acourbot@nvidia.com>
-- 
2.43.0

