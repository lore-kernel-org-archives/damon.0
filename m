Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8123ACF18;
	Sun,  5 Jul 2026 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285082; cv=none; b=YRx4Xo5ME0+/mRsMEjkq8fIvN0M6aLCrv/dkDxdBQIZZb2Mg21Iky+zqxKZFK/feqIl5746zp3wYA0ho2TgXnZVy6TzOxDF/kn1rTiIfmxtH8HOL/J9dzLdxLoLJLTF9FdaBIfGPaZrXS/khmnJSv/eFlGFo//DBAUQJLg9Kevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285082; c=relaxed/simple;
	bh=76Ms7lr2E1n8a9s5BVP9BtK3Clv9+dktfC0KcnJw1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McRV11bVTQPODBv1AxhPqM2Xbp+u8Jfw3lOVv3CdpRO+T8HJr1ninOuh+FekKVRUeMn8B407JSpUUc1pPICl09jKzgKh6izAd9mrqf5PIHGiJBLYK6LtbP2RY+QpPnAN8MgvCuQK2zPbjQo1zO2CoBTnQgD0fTCZqU2UI/gmpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTMI8lp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTMI8lp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EBB1F000E9;
	Sun,  5 Jul 2026 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285081;
	bh=KtGhb2uuQghnzvwRekFMe5vHCrkMdKOrMY5ghfXYhj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gTMI8lp6qATBOVzhhoeE1r8uORiBxuX8LinFw2RoVESlZwD2Cdg2pNSXqElTaOXvC
	 ZKOsV4icBCeUUaEpYlKbkEHAt9kRboadz1Gg1gwV9q29aiS3bB0B192nnnii7v05ru
	 NCUGnJg/Ocwpz2QEzhRBThu6ldXWPFsLPn92Dwyi9udCOLwgnEG0TZZeTxkxk4LV5e
	 UFOm3Ukxt1ugPLyEAYrPeKDQEZMoHSKDBQri5xq3BIyzN2FcptiMT/q0lyQHL2atVy
	 KHrRUS4FIDKeRih0/LZmHQ6Jii9S3cRoinpTgJED/7p0IS6UI3IWpsShcpuKfQQ1BL
	 S+xCDs2A2CN1g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 16/16] Docs/ABI/damon: document probe weight file
Date: Sun,  5 Jul 2026 13:57:38 -0700
Message-ID: <20260705205743.98656-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705205743.98656-1-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added probe weight sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index dd6b5bd76e119..907a504fb64c5 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -164,6 +164,12 @@ Description:	Writing a number 'N' to this file creates the number of
 		directories for each DAMON probe named '0' to 'N-1' under the
 		probes/ directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/weight
+Date:		Jul 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		per-probe attribute weight.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
