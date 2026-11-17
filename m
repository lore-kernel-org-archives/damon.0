Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794896432;
	b=0TR9beY68+vtRRGh5gCfgYQOqtywZ8qp6LGP8d6yXY15WSfH+WaL4A6aLoJbUoje+n4H
	 2ykKEFrL4be2sUiXpxEEMwBo2QNvHficjUQzsfh4gDOFkrtHlRJ+bnoPERLQWcX/4uZri
	 LxCKP7RJMOq29Ef0ci6sAfmSSOoiW0aEHcYX/Hy/I2uRudm8CjSwjiIfjLlysApY3fTVT
	 cyZPWFs67y83MMYtRyjTvqPiqbWofhQixOagIfAEON7gUMc2HnqaNRTLCBMCSebxJO52y
	 URZXdIDYONqt72YupCpJR5Gt8ZgxgqVuMrhVllxjG9WnOhvfzhRiRRFcE4NBeUqeFMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=1DDRt7N0cPxO/KFQj7wkx+g70GiGI/WkpRraj+SxGOY=;
	b=UQqEpna+TEY6pHme1iPASrJd50Q5U4Vn6MCi8X43hEk/VMLIyuK74hEDONsPAUXBQtAy
	 kcoiZ0rOeZRuvtsswWFDadjhUL9W1M1OPt5n5ei9rn8/QN0dpJyr3e298/WPajcQKhA1g
	 aigFBL+ujb2FTNK1HgyaOqbHcEDO8NPTSO/042Cz6SynM+oZH0wqWBim7wo3ppYTeNVL5
	 tNVApr9MIVK8xTXI9pQNPYqDl5gtZOh7DM5FXItlQRnGSeR/N6BqRbJ/9fnf/ZjLXQm43
	 qsN6XtD6xsDkzDBfc2tGrA1xWmuysuSa4bXjWUXNByhkh3+/umGfJVW3/g465QIe58A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUJufHNl;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21895606A331
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 06:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21895606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KUJufHNl
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2ed408b0d0bso24535065ad.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 22:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794896431; x=1795501231; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1DDRt7N0cPxO/KFQj7wkx+g70GiGI/WkpRraj+SxGOY=;
        b=KUJufHNlIcqj/Mq841rmz8mIlipSssj8NF2T76B+0nq+vxz1vTy/ai64A9jJx8TMhH
         SBycOjw6xSsn6xEL0VF8n4PPOiAMI0mz5kW+mneCFqvpuyNaYH3DeADutz8MTnbWYBBa
         OnrDZ2f7vhpWuut9SOOtMzKVO7lwgMHXBbtGlcaEwNv0IxLMP/Qy/G9X4fd5hsvjFSei
         1w4SnYb5QBT+ThdKPz8ucNmTbnegxx3AuTSUaDQfrvCUT8A7v/C6Avrf8wWTbwM23f+I
         eZvt4bmnIBCe3UdZXMKoiw+3Vu66b/oGsJnTN4Mp3Bni/vpB+JHVbCew0g7jeHqFoTNY
         BEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794896431; x=1795501231;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1DDRt7N0cPxO/KFQj7wkx+g70GiGI/WkpRraj+SxGOY=;
        b=qK0VaqOotf22SbwY+A8O+SlHbmNW271HvKekcBoOqmhoKJm+pZFNkolkwtm5pMo0wN
         EgYq4DUIk2VguMBH5RTijsI0cQ85Fp3osDYwexbXvTH2uGZ4Kbpk2nj4nYv75OyUT+M5
         MO1kZm/N/oL8ewMlri7q8N0zCp5I61n85gOa8ml6xchmbDK04jxeA0Pt7kYXD57YbghI
         AOSKInzCBzh0JqnrGFkoB+2sS6D6wuF/PDv2DkAO4yjvwjha+XqMf+6CqocOpP0becBK
         HmztgEmLprydyyQGCaS8mz/Us+uSsRiwAaEtPTM20w7LbNP2pXexhv4c0YMcs2I5P73g
         v5XQ==
X-Forwarded-Encrypted: i=1; AL+hErErPVJIkA7a6DTbGrWXdgyWOVu7MRV5ESl5KYu1m3aZPSZY/6WVxVp7qsZh6r0UMDMBDyH2Ew==@lists.linux.dev
X-Gm-Message-State: APuU4Z/J7mQGetqymEFP5Br/dPjG8GYn5ZfjdLS6ORkLqJPELBwnBolU
	KW/ogIr96l+PmpExKdeSExqZwR4I7EBRhLADNSvxn1Bl4vcQUJyG97ze
X-Gm-Gg: AZFdTZe7zoMjemYm83kPFDilEfM7xdXgnfDcC2UoDqB6QYqceuK6AZWo4BCN9+oWD0B
	Yw/oX+Q7i0uAF/AjJzx8hJy4UZFPRAlP05X5/6BIWkKaS5kqW1ZecOLj6iUKl/g/2r4g8ptwOFb
	evyPG4PAkNIZozSVZhD1f2Btpzh5Uc3Xz67/+zzZI4hG7P8IGeUY3gLDHd2IY0qGGwpHvqh456k
	joXGARa6cPKztODjSM2E2Ml+gJyH74KoHQkHIphaSHTUNHda2TMxGPmoCB/4p1Z24qY/nIPgHLw
	pidnP435zIDfCWNzqilNPnBoCqOT35HRfnpl3yxiy0myeQbjYnfQ3dDa1hcdQvu3owhuIL5e2ex
	TUg/qZeMtX97SP8SqrkmRS4e2rPvvC5vVVQDw8fH/4IGAwGnOWpgIJK3IUCTfG1ihCrLJ730HOC
	FqaWlGOuYvlUtttSKtZ4kgLbg1CgeehKLvZp4Fvd+rbbCMccMUAVyggJPBrr81Ej2M+FUseCA2D
	Wv4/M6zbivj6N7vHXLQQ9epBEf1W99C8V4+23lxI3ZqGqHJL48ZuDF5fUQVZIQj2oVradYm/GAb
	Ib+IpbxuORzFZOBZCnWcKMNjtqEPJ/jU4J345yyNWNeaMs9MkK/OBhOqJWHuy5bhlY4ZTfBdSIX
	DtaHk2SsFjzbwKLRP3LNgKWs/e0c2rqbctXg0YX7Ha9PzhQEibFBHRmlfae+eyy4=
X-Received: by 2002:a17:903:22c3:b0:2e9:6788:9369 with SMTP id d9443c01a7336-2ee0dad1a75mr127580975ad.34.1794896431357;
        Mon, 16 Nov 2026 22:20:31 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a5f754sm8776345ad.52.2026.11.16.22.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:20:30 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 17 Nov 2026 17:06:54 +1100
Subject: [PATCH] mm/damon/paddr: skip hugetlb folios as a whole in pageout
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-fix-damon-hugetlb-pageout-20261117-v1-1-054ef8760a92@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2NwQ6CMBBEf4Xs2Y0URaO/Qjxs27WtkZa0RUwI/
 26RhOObzLyZIXF0nOBezRD545ILvoA4VKAsecPodGFo6uYihLji031RUx882tFwfkscyHAYM+4
 VOnN90jfdUiuhiIbIZfU/6R4bp1G+WOXVvDYkJUYZySu7Rps/T2F3HvsePU+wLD8rFfSysgAAA
 A==
X-Change-ID: 20261117-fix-damon-hugetlb-pageout-20261117-a4e03d9d5a5b
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0

damon_pa_pageout() uses damon_get_folio(), which rejects hugetlb folios
because they are not on the LRU.  The loop then advances by PAGE_SIZE and
looks up every base page of a hugetlb folio that cannot be reclaimed.

Use damon_get_monitor_folio() and skip a hugetlb folio as a whole by
advancing to its end.  Do this before the filters, the accounting and the
last_applied check, so that adjacent regions within the same hugetlb
folio are not walked by base page either.  Test the LRU flag first to keep
the hugetlb check off the path of ordinary LRU folios.

In a pageout microbenchmark in an x86-64 KVM guest, traversal time
dropped by about 99.7% for regions covering whole 2 MiB hugetlb folios.
As a side note, there is a small overhead of about 1 ns per region when
each region is a single 4 KiB page.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
Tested in x86-64 KVM guests.  KUnit passes.  The damos_quota.py selftest
can also fail without this patch; I will send a separate fix for it.
---
 mm/damon/paddr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5b773012a876..aca48bf752c8 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -268,7 +268,9 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
-		folio = damon_get_folio(PHYS_PFN(addr));
+		folio = damon_get_monitor_folio(PHYS_PFN(addr));
+		if (folio && !folio_test_lru(folio) && folio_test_hugetlb(folio))
+			goto put_folio;
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;

---
base-commit: 67f3b04b277373438f17300e056306adbd9edf7b
change-id: 20261117-fix-damon-hugetlb-pageout-20261117-a4e03d9d5a5b

Best regards,
--  
Aveline Noir <jm5905938@gmail.com>

