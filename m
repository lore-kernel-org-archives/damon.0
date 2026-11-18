Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968556;
	b=R4LkuoPzzlgVhTr151eoHJi1z1+sr04PlCE6grwnxPgz20/oMToWaVbiFPFG35OUX55d
	 AZMO96Go6SxXz6Mog/+vud2VkV+cmi7aWjy//LjwRrEWQpmuO3p41v3Qk6bmFszUBDggz
	 gs55F2V0wC1bX6OLdvljS53A+J+Xi4tIU/jiIzXO1F/Glxmfsa1cUVWgHIWM/CDBU4xiO
	 WOGxK/o0uWy3hXIsg7hbSRT6d7uJ5A4Sj8OS7fitgg3pA4EYUvtV6c4PPW82cTF9jJEKU
	 hb8vEBhGr7Acf34k9z5+vr1mHk4NuV8rWiTtCqLcDSiP6nXCnapcvDtnPjcwEsjCKeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wpJsxUs5k/v5Q/BJmFbBidw7iSSRFrTJt5QonQhU+Vk=;
	b=S14zwGsuhDYZYEHDqVzqlrxo2l5t+iIYadusmSEhwpTKOorgAT0e254oL39gpxDqG4gP
	 cT+S/bPhVHLBSgOW3oTDbA5Z3Ian9UMGGlLwR1Nl/BLYGa7iykumOwoQmcLS97qHxiGN+
	 QkS9aZ/nK+otiyetwv0tiGbvj853H4UQsDc8uel71dfLtmggIEg5mz9zoJtu+Ajx78/wf
	 9feNxwZyZRKSV5uOGq42kkYLvA6d1cQd21pA74m6cPKYlPwy1ve2CmGabu8YtCBV6ylHR
	 /FzgcCplCCp13ojmu45x6/BUvHygKerAvy535KeOffGP/HUQke26JJUw6aURg9FMKjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKLqGCrK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735CA60A2613;
	Wed, 18 Nov 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKLqGCrK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3502A1F000D1;
	Wed, 18 Nov 2026 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968556;
	bh=wpJsxUs5k/v5Q/BJmFbBidw7iSSRFrTJt5QonQhU+Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JKLqGCrKEe9L/MUJ+Q4hSknRmF/yEYHn8OnP6j2BExNnfo1iAddeOzs1OPfL4bs/H
	 M4oIHnNoVd0MstriSeN8+eZx5MayPGcaI3/h6y4lIdEiPP2VwtfbyGAgb7DhchzZqc
	 LZBOr6tn7ONXza7pHmX199WBjBb6X1VMsw46GlyQijq97revk03FoSXBsu4IjSaCUF
	 Hv8mnMVY1+ujqwb+jSNy7kdB+6eEjgWSF7yO4uK0vW3hld8by7gVbN69OhlQBF9b4S
	 0Ve0baJZkbEvmkRh73dLBJga1CD0dnwL3FYeyW40LL0MeAzk0lrB/XYWFWq2ohXWH3
	 1kb5M3atNgGDA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 11/27] Docs/ABI/damon: update for report producer sysfs files
Date: Tue, 17 Nov 2026 18:22:06 -0800
Message-ID: <20261118022225.100659-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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
