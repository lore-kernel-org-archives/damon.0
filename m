Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856223;
	b=C1goHL1IJyOh0iYFgFVq//nVe3MYWaP3xOehYzIae/U2iK+JR29Ys0G7hSXTJQ5mZqKm
	 paWt5RGbK/7MoUnsCeX4DjC77yBT37SII3XAslTr637xmFOYje/tJiEMnKG59dBEA4goP
	 3g6Nvy91aPq+ATSBGvTkqXvrTrPwcwslFclMVjOwZHtlNS6JMuL8zO1o+e0fPU/h35bbO
	 zkBW4k7XAXeLEGcOnntRBqM3mm/1EJI9q1qG7p1Dn+UP+n0dUjW/ZtSTEC7IeKjRRq6Ix
	 cLEEyLTPN1bCE999560FF0psPuNGMWAOcPBJsvXUBOq+FU9jiwcDkuYQOhGNCO8jDPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856223;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DLgUcDfAseuR3yJ0CiNG9qISzP4xn7ICnWPspQDKS/A=;
	b=tjo4Pjo4tPfSsatMULJYj5sOYLZv+c7C7QgRUhZaStWNdSIoQduHukbTtwfsUGK1vK0s
	 E2L1Dpob11Wzt4KShQ+1+7GdWV04lO2lgDCjucysv8hs0hAv16IwzrHOB7SI1OLojVaqF
	 EQn68KTaM73vvmtksKJtobFjoV2nO16yXrCXXvdMNou8nBvN9H9E8D7Sg15Vcytljsgsl
	 o5xNtQmGqFrZv1V+OB4+8TsiKEE76KYcHAk7jwUhz9lBsRPTnLrHUlaTbkxu9mVnaP102
	 zDk5yE3xw/b1Utt+ZrdnxXpp8d0Bs4MsDk16cK5UeycljQG7fBNEUDH5XU5E3ilJ0Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K6A/F4Ea";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD860A260C;
	Mon, 16 Nov 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6A/F4Ea
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794856223;
	b=Qn+lzaq55/2Q5tV6nYN/tTyqEld2IeDc8V2l5+l84WpkMh3xapv59HCn7dlJEtWMYT00
	 3lKQUKkNC09jeOCUT6GHBQfGuekvJ2LiRxDmqpbYZl4k8rBARG6Q63++KlDR0rb1wp5dP
	 WTGUAmalHt5PC0ZW3feqtnkiYLOYC4tXnBZr3cZELNVLqtUXzFEqOGlw9BgfDzzw3gNFP
	 jt8e3CeF2fNAL78wbzl+vIZpwIUxdPx43FKoEh45RsyJlsZrEL6NDVdBk9pHauiAezW4N
	 Awm7ReU3hbzqZs7dNNERhUyVjDvxagJBzzBQZ/HPA/MuGSUNolXrnQwOeVRUFw3snjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794856223;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DLgUcDfAseuR3yJ0CiNG9qISzP4xn7ICnWPspQDKS/A=;
	b=qYeCGUP2lvR6MP8UXIgpV/ccbFXi0y9JewGnv7Oa9JxcYwbMbQH/ECJmEy32Q6X/zfXe
	 N2ZRr8Crjqs5xVkPpe5bvK85chWVbaIxgE7FyOJMPLwxoqCGCkhgfEtjX8dD4QEoQPSRI
	 Vuo4TqJe97tNzCmhYg1EEQGWpbQlPt44n5N3D81K8TIsoWXFD3zc7X8Nth3l/7ux5+JFF
	 BOT7njlP90p51xdftTEBWCcC1hak+Ft/mxGTZRGh1cIPUaNTALEPEk7cTRyReCgtWHFJh
	 cuqnFcRbL/FMj4Zc3vCxfEbFrZ5Gp/9GaTJlM3tNfpkA+hb/TsxP9mHHHShNhcF4YIQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E4F61F000C7;
	Mon, 16 Nov 2026 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856223;
	bh=DLgUcDfAseuR3yJ0CiNG9qISzP4xn7ICnWPspQDKS/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K6A/F4EaG4jUFZ0ZBS5ziKNbNT6Bh3gRmWk3mXDm0bf9xFHOD0/GVF+9JtSnDZ9kO
	 qD/7gRCqLkdg/IXbMo9a8ffSazxXCc2LVFqqa9O8EDiYX1DciDJJQpg/W/g3memeUT
	 ZF4ZiS3bD+Ca6FiRg0L46mwQvZBP8gWp0KH4dHWQkggLNtDxYWKnUP5hShzyptlWfW
	 jWotLk/ZmfVrfL6MkPCt16DD6J6aRYHkmjTmek4DViR7K17UishjaxPz8KFDwVC/87
	 TxYypk/MsQTUEcxKInOnU4ShL1F/gxkqpuG/0V2fyupT9ZwmSh11OlkAjsYrXVXW6a
	 BstQ9pkwqiHiw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AAA674A5A5;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Mon, 16 Nov 2026 19:10:08 +0000
Subject: [PATCH 5/6] Docs/admin-guide/mm/damon/usage: update for
 sz_ops_filter_passed_last
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-damon-sz-ops-b4-v1-5-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
In-Reply-To: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794856219; l=2099;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=oiIYUzWQ/llW0+1v4VIsDSeWAi35sgosZXSLIgAe5qQ=;
 b=6ld5QzPT/dJkRlFCAL2FvutDAyfX/kfm7BgZrwH8jaVtlFk3UldzuyTjYS4LsQkmatBaJIsmj
 pQpun2dVtjyCpr7x1upic80JQhivK9dQ0KmDguZOkJt5CVMwprRvDT7
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 8bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON usage document for the newly added DAMOS stat file,
sz_ops_filter_passed_last.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 6093b1c8fbfd..c0101a68a033 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -105,7 +105,7 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,sz_ops_filter_passed_last,qt_exceeds,nr_snapshots,max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ │ probes
@@ -631,8 +631,8 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
-``sz_ops_filter_passed``, ``qt_exceeds``, ``nr_snapshots`` and
-``max_nr_snapshots``), respectively.
+``sz_ops_filter_passed``, ``sz_ops_filter_passed_last``,
+``qt_exceeds``, ``nr_snapshots`` and ``max_nr_snapshots``), respectively.
 
 The files are not updated in real time by default.  Users should ask DAMON
 sysfs interface to periodically update those using ``refresh_ms``, or do a one

-- 
2.54.0-uber3


