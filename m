Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774549;
	b=aCCh2/Km76I75BNAWInMYyyO/ESEkAEcYC3/u1RN3kJtHITvCEODwiXgO4xzKfuFO9U/
	 NdSjtm0XJAW8m8msV05oqWAic5wJdy+o2YZjzNZGKg2NRMDsz33/WrNQOIrj+e455g4Dc
	 RaX9Kj4m/YZUVK7CTwZruf5oLDEyiLymUX6vim3FGA0vML+CGII3sodlB4QUt/Am5oXyY
	 l8/HlpBykwe0DxIxdgIRFzH9HD1JfwjowjviRv7662geK2vfCSfcPlcaJif09q0mRZRg9
	 ImJykQndVKgqSjuiViEeHdCbNdLCktNRHjumNqQo4Xanc15qTUwqzN098UgVV6xzl7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R4c30zMvWlF/HAu21CDBSrVZTsdtRg90kDV5GhwCdMQ=;
	b=JufGvlYDSimMd7nWEHju2G3vz2KOpDPGlOKn1xFRSB8ep4GiUqgcPibefpeHBJ77Lzjj
	 wLR3UQF68zCwJjgJjCD4LadztC+lASa/MUsPZIC7E11rWmjTXzTdv9T0vM9X8sSaliz+E
	 Sow/wpy1LvbzL7vuiPTfX5GthP4ua8FXlevwXN77gdM0OOy1K4tMJP4jV+dzKJz7Pjg57
	 VsKbLwLQCpMBULaIhKNOchgdvuKtniEqL3IbJhQD7k+X2hpyV9/yGtXfKeP5DubB8ChBN
	 mbZkTnZqGKjCJFubgCj1agwAxOSq974EMNv2hx5dV+rmRU2W+4xiRiNC8SXxwE1xtSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYkoSKuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44E606CC88;
	Sun, 15 Nov 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYkoSKuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AFC1F0092F;
	Sun, 15 Nov 2026 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774548;
	bh=R4c30zMvWlF/HAu21CDBSrVZTsdtRg90kDV5GhwCdMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYkoSKuWfQsNuWi/eULR3JcxU3gdigMHHsHn7j6bwN4bOEIk61BwtVIwGSymSTMzG
	 u/AD5pWuTZX3JM0+maLO8ATwa+b4ik6pfB4nxZXOtabiRu9AF+kXkrLlFXv842GxyJ
	 PViaOWyRnUijD2uNU/zBC/9DAj9fV72OEu+jsJLAhoiiOU5Gt+GK7+XJhXO+VDXx0h
	 aSnERvsstocaZzq/1S0uFSsXk5nO1kRchFqyRiLONy5dTQgGJP9liDtmuViR8eabnM
	 Z6kA+7vRRaEowugbShKIbbmCdlQ5omxQWC0H7SYUvqV5BD78DKdpOXlug8W/m+DJiE
	 PVxiB+sHeR6ww==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 19/27] Docs/ABI/damon: update for REPORT_MADE probe filter
Date: Sun, 15 Nov 2026 12:28:37 -0800
Message-ID: <20261115202849.99134-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added REPORT_MADE type probe
filter support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index c9f718f126c70..e558dd4212f2c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -233,6 +233,13 @@ Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
 		hitting the probe for the memory that satisfies the 'type' and
 		the 'matching' of the directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/filter_report_type
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'report_made' is written to the 'type' file, writing to and
+		reading from this file sets and gets the 'report_type' of the
+		reports that this filter is working for.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
