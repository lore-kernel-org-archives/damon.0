Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294825;
	b=WOAtcYsU3fzxwTd83A42WnjyGnkUJsjEVXPpR1SeraSJWxgQgLDyD4CjFH3fnD7u47fT
	 +46FmUXVSuojdWnd+uRUCngndxdphfxGcA3vpgcR1JIhphWSDA4SOeZvuNziZa9WTmO+z
	 B/xMFobYcAy42LyfNzN2A91omZMJKUR+TjMvdaSSp2KQuNes6wUcaavJ74w9HbjF5ouHa
	 Az83uHm/AkLfh+133kmniy6jxtxGJ1DldpUEldguc98akrPI9r9KoG+zYbxGZb3E2NVnm
	 5SxDmF99z2IX9r9cJyydAGHFwAAzgaPiqFW3kd6dYSgNHX8goK7Xmlj6YGViEwcIgOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wpJsxUs5k/v5Q/BJmFbBidw7iSSRFrTJt5QonQhU+Vk=;
	b=YdfWpoA+LLuLePMy2yrygekoIFJU4W8Fwe+GjufyzTkuQjdRHeqzWlLXyx7bnWjca5kO
	 SAWD72FFuFSKtF2LKgYIXxI8gvV9W6mREV+fYELtjrFPNheioVXqJrcQOl0GSEu+ex6cx
	 iKVwI1sTahYk5mVcP8EWBNZ9KLwIfkytZnkSuJ07CZFk+nL2QF3NbdtmwmGri9v6NBShB
	 FuTBvr4AzYdHC1sVef3iAG0dhQQapRk/WOiOpJ+sakkbZ4p5OXENBiKjCIJasfSxeq6Y5
	 z17yuQtGk4N02BU5T+IbmHHjZ8rUCr73TjLSU0w4tVZObWPryxeoET09UeUwOMJx/og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2eZCaOa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5E606A332
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2eZCaOa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB71D1F000CA;
	Sat, 21 Nov 2026 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294825;
	bh=wpJsxUs5k/v5Q/BJmFbBidw7iSSRFrTJt5QonQhU+Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2eZCaOa2aKMd/CrmQXt/qgrdcuyJzM0P/hA2y8q8H2Q8EGdaVcKQwdJdSSXGaGBk
	 VFH2UeFQFh9lNY99t9n5BuByJ8YNrVzgrb6dvFYtK7CeT7ytYleSBj4Qvbr+ajC2yh
	 QX3h6IdTxg5PQJl6CoDvskpoez1hXthjlcIMAkdwv9lPss6RLhizttIBJZuvL3l4aG
	 F0CzqHihb75pbd+Ey0d1toKveTD4BdKSCVmfRCU1QJTwId/GxKu+1xHOKNqaUE+qxe
	 TMNjd680UYMuWsy2asKwNu5p/FU1iy7JPul0NUVS19PVqQn0q9ldrWxthzTh98yLv+
	 DagXLNwbadCtQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 11/27] Docs/ABI/damon: update for report producer sysfs files
Date: Sat, 21 Nov 2026 12:59:55 -0800
Message-ID: <20261121210013.130397-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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

Update DAMON ABI document for the newly added data attribute report
producer control sysfs files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4acb2015c2f4f..c9f718f126c70 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -695,3 +695,23 @@ Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
 Description:	Reading this file returns the number of data-attribute
 		monitoring probe-hit positive samples of the region.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/nr_producers
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON report producers
+		named '0' to 'N-1' under the 'producers/' directory.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/report_type
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the type of
+		the reports the producer will generate and submit.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/producer_state
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	A file for requesting actions including enablement and
+		disablement of the producer.  Refer to
+		Documentation/admin-guide/mm/damon/usage.rst for more details.
-- 
2.47.3
