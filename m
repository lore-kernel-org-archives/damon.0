Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727187;
	b=poRHi2sIiW271ykY+kg45DSFBzODwgu2B8Xs4b4PNU2SxChPeI20K5ux/U8gfybnuTnp
	 tXPDgTxWb40edarLn4KnWQepllkt9UfWwnM18Sj3Q1uDvevPIgjidscer3/SKIdojtZDR
	 MPHHjb++HRyiw3HD9pEgwdnqsPQbb7LZwatxCdisnONEl4ja0eEsjohODn71mSk32gn15
	 L1FZ1nc2CgjDE6faeU4089hx9Y19pywRI+92lsyh7SKp09CeNyt8j1uS3UgOjq1Q+IHp/
	 AsSTIhD1pq5TkVSxMJoa+lWcKMIYU60dehQE9sxVJnyX+dUTi1SfKn70eT1jwaRAqOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SmsKR5t+Y2D3Q8kD5C96vxFY1u4bAkMjmbBuKnE7WFc=;
	b=U8B1MZbOCbOUw9AgdZNpy8rfGNWNX3SOcncZRZY5wghGxhvcwpRmKv8t54lXjtpTG7xr
	 uEDtkICWZBEWtvksx2+dOFeucYjycnfWAkya30jElAb/OITIhghPF3GSh+xqjt+/1lsiJ
	 dBa2yoaFeGcI/xXfBA7i3pDWQZuRXhAXeRdVbzcWx/cOrAFL1Edr/uW/Roppznyb+gtdG
	 snpHaxzrU8EJiZeciQJx0pqWG5kUg3Nj/034APGxRiasvhl8RptU04AOakjMshWirYBR2
	 P87VluO6kXDHeoVxNinxuf5G0IPOxPjljNNVlGWOsk0TBkZmlZZPvV6JWG5d23JtBcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTy4ljNH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D6606A326
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTy4ljNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B911F00893;
	Thu, 26 Nov 2026 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727187;
	bh=SmsKR5t+Y2D3Q8kD5C96vxFY1u4bAkMjmbBuKnE7WFc=;
	h=From:To:Cc:Subject:Date;
	b=CTy4ljNHSQBNULlk7r1Rue8XR9LB3QbWm2NPo6GAYi5eKdum8znNEBLBvhyucFZIG
	 7iQspPA6uDGGSlceUeKxvb5/SnGSmwYnquOzL9HrVjDIwCREaOWRbH/MsdlkTBQe1b
	 rJPdEOIDOggKuOgigUu6TwZB0xuzgnbesIOL7Ue8eeiOv5sgecRwr6uhspm4cyExDF
	 Fz8+7vzovkqea/dKNtGvsr44qCkI2zBpWdHhvNzT7rcafgFZ5rrwhCN8aQCeLm+DAd
	 rqyBgE9dwYjwFTwrns+ciIunWZUXH3v8UrrWdqjcs2itzVOxNqwgpFxAP79Kzm2cq1
	 ooOP45NKXzi5Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/damon/sysfs: refactor state input matching
Date: Thu, 26 Nov 2026 13:06:13 -0800
Message-ID: <20261126210619.97634-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

DAMON sysfs interface uses an array of strings, damon_sysfs_cmd_strs,
for kdamond state file input matching.  The array has expected input
strings in an order that matches that of enum damon_sysfs_cmd.

It is easy to mistakenly make the order broken.  Other file input
handling functions use dedicated structs for such matching.  Use the
pattern for kdamond state file.

Define a dedicated struct for the matching, and an array of the structs
for the existing inputs, via patch 1.  Change kdamond state file write
and read handling functions to use the array of the new struct, via
patches 2 and 3.  Finally, remove the input string array,
damon_sysfs_cmd_strs, which is no more being used, via patch 4.

SJ Park (4):
  mm/damon/sysfs: define damon_sysfs_cmd_name type and array
  mm/damon/sysfs: use damon_sysfs_cmd_names in state_store()
  mm/damon/sysfs: use damon_sysfs_cmd_names in state_show()
  mm/damon/sysfs: remove damon_sysfs_cmd_strs

 mm/damon/sysfs.c | 83 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 19 deletions(-)


base-commit: 4aaac77f3cfbdce8de54359c1db84b5322ee5e1b
-- 
2.47.3
