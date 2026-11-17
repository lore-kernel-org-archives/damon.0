Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794957790;
	b=AZI6vgO/GjtQ8RJJmZpomdWhzBHa0tn5YUgTcRshB7rBBn1tenoHjXbsmrtQ93dDYa2v
	 PYknbr3WH6Q/ueJgrEP0Z344CphuUCUJWuqJ6yZSWUWD3l7CMQAeP/dR9JJlZNF53LJ6j
	 wrDr9IlynkRMq2EklQh3kt070Yez5Ou2qpwqpM8VdkxgU82dD6B1oF1qqAa9ZGWChc/J2
	 7Wab6gY2bF7BE2NbF6xwB9QgfBplw1ERV5pOIJTuiK2mJjiycV9oRgfhSQerT3gsjkKL0
	 p03XtLVjJZ4EklmvRSpdQmUiylFfZC9JoHSVANhY1Y0lNdJIHOv+Q+NCGnESk3EZGzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957790;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Cue/7N2uA7x0b67B8cg5P6aqtiRdNdHZ/UkP/gcIMjI=;
	b=dXpedY4huEw7hVcPbpnYcuMDIjSgPsFp3QW4SuKckRXncAWHYt7DsDQGFSqZyTFex0fa
	 hSX3Tm63OsX3NaiEZ6cNU2gFSe0caKIhoBCy+hbtdATXn1QsXJP5+ZetI3LGsaewD+QaZ
	 tRHIyBmt1yGiXt4Joip4MLZ66cWjNBfPl0TZQa46XXb/c16Bv9JJ9KxZD7Wyo+hXkznaE
	 T53PNzUEq/pDy4bWMIVKhzM7v4wv1DbWCmuj1zTBmIZ9HnoYS2iqBiqJsHAHtHOsLTwA/
	 hk5NGCHHwz3Tyy2evlmOSkSP6Cgnrr56UomJXQrjyMcGBLVYMI80VavOTK2s3/vi5Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhbAvZhP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766C606A896;
	Tue, 17 Nov 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhbAvZhP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794957790;
	b=CmCybs9dPshIBK5dI34PUg5+Id4sn/MC9dTA5uPBnmxAcPVue4pJmi8hPj0kXnnUEMJx
	 fmqWosM1EWmvACQw2/ebCsjI2VvT2IW1BIWQXBWD6em0W1ceeZRedSA58sGFC+fxDVZfn
	 yMrXz6rMyZQKwXFvjy4N9a2B5tBsUxed9/aP374/EAIIefHTbIbY+i2twNcGP++lDNYnO
	 VI7sbv+KBaN3hVl+aSeTHgI/OruiPkM6UEu9fBH4AsToWDK9XHjbKKq9gMt/s/snQ3zVd
	 8WD8mRtgNIYkDoIY4xRmK4/ppj2ry0u44h/49XxGDbSuyZX6UnvnzKX36zyDLSoTovg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794957790;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Cue/7N2uA7x0b67B8cg5P6aqtiRdNdHZ/UkP/gcIMjI=;
	b=a2AUSQ9RuECs+gjJ9SdsxraqHcwvAsL87t8KIjHXt8rstqHqMXYuvMH8F4hhtnb+lMe4
	 Eo1btDeiGvvGwX15LeptjsMMw8ZekJe3DWlkVV9WzBxJ2tRW5bt/eKQUOJ0KG70TOgrC1
	 tHyytxprdQo0CyYiXOKZrzv6hUlF7wBgdnSiY6HyXsE9IvO9rc1q1hiuvw+Znkg5DdhBI
	 DqbdoEBnwZKmY1QukWlrjJ9Wd7Yfuj+NXe62UsdvZ3QvF9XwWX5wyx5geD8y8uwVZ+ysX
	 aK6sBi6VnIvBLzM48xjWvdwfP4IPUjgabnBSNoXP8KYvD8MNPUqfsjhF4O9+Bl+dK8A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8E4E51F000C6;
	Tue, 17 Nov 2026 23:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957790;
	bh=Cue/7N2uA7x0b67B8cg5P6aqtiRdNdHZ/UkP/gcIMjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PhbAvZhPnjSxyiLY32V3TTIWZQ4/coLalRJ+dZAPFCq2ZOBUWyfZXfa2nZLH6fTXo
	 m4fW8Oicx+B2ZI1D+vpC4tvTbVZHffczZfvuQuaFoYLvSEe5HmYgFO3gTLBTSPblGV
	 /WIzDQYT5xhQKIxhDZL/uhDZffv1xQ45zXx0kOpvVQU/o9+ulJ5BI+BBNfrk+MpctZ
	 PJ58mDSDjnmNIqlL9C1NIi2AdoG43b9db+5L3H5dEnN/dWfUT3Iet2RrqPgESBuvlp
	 AM005YrJOk/CJA1arwxC8HDriXMh3AONQrxWS+fd70ivkl/czQ3GDXm0RbYkTKukh5
	 XkU9i58H/jvnQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 15F4A4AB4B;
	Tue, 17 Nov 2026 23:23:08 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Tue, 17 Nov 2026 23:22:19 +0000
Subject: [PATCH v2 5/6] Docs/admin-guide/mm/damon/usage: update for
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
Message-Id: <20261117-damon-sz-ops-b4-v2-5-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
In-Reply-To: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794957787; l=2220;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=tvJBR8JDDpKpw1xULOsbisctgZ8T255dOmTkH3Mq+d0=;
 b=sn9jKNfNT452I5qkbsBxzO7juwhpsdzcLKXVP8IlWA37FavQ/FVK/H/BHGFb4SMBeN6MYU0x7
 ZCSuZGNmB3uAaGmXVWyoK1VIwPRJijhPDgKYBGx4YelarTXegoxiDD7
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
 Documentation/admin-guide/mm/damon/usage.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 6093b1c8fbfd..51c4909f1a8b 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -105,7 +105,10 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,
+    │ │ │ │ │ │ │     nr_applied,sz_applied,sz_ops_filter_passed,
+    │ │ │ │ │ │ │     sz_ops_filter_passed_last,qt_exceeds,nr_snapshots,
+    │ │ │ │ │ │ │     max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ │ probes
@@ -631,8 +634,8 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 
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


