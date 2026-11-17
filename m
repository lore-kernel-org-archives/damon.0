Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987625;
	b=nvDJ7hTIYcYfgNLeH+8uNXupdUJ/CVEs5OmMmo+ksU2eSnAuEv/SAgGyBNG/Vkn20ZiR
	 iGWb2eOuZepEqifDNCYcTN/6ip2DBuQsmj/BEJG058Kf7LdDMrSoESXwXmOiHHcyl+tOq
	 AoDcRm5396BpBE/kH8jRO6q1rvYTB1JA/7+T0xEoiqbKBTyEWGJypW9/Reue7shb1sBLd
	 PMNP+Qr/MOwYpbyzDlHPv9K0WfqlR0MWeqLaoB/OHuS5mD0DsC68G/7LCKH1hD4IWSdVw
	 Cp5SEOZtc8Nl5jis9COJqoNJDcm1H4K4Sc+Da1V6t7Kjaod6TQw8GUWd5y6o/hB9bhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=V+Q/b4oQQRcc2ev9VIFrb3ozJoPLTXTZ4ZqHagDQPao=;
	b=IGf6617QgTgt6Z7clFl/MtjVQDQYcg5ueUJ5H6EwBeXeD/gwz9im+3q1xAweHgYjH5vv
	 hmTuU+pHxmYfT5CCHfIYuZ2Ksy/tRJzehhqHckjW02vOF866o+Y9ACLvnx87bUR6G4DKO
	 f9dIZZySDfz5CA8f/8kWCgIv2KNFGfLlmDLSRggAy9ryMUlar/ZZI+D9IglnkN42bN4gB
	 6jshq8x4ZMbdXNPf2w0HhJ/lDPg5Jjz5uY1pRQK+Fw0d2Qsg/tq6SctJcUIFh7IxXfDmB
	 SufTeIF2N5UuZcFXCk4+1y+HlwJdSsUjAt8CrRdrOq8oflRoFsK+hJcJjI6RCWPLckg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aThAsX8w;
	arc=none smtp.remote-ip=74.125.227.128
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31E606A32A
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 07:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B31E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aThAsX8w
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2efd15c7545so1847895ad.1
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 23:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987624; x=1795592424; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V+Q/b4oQQRcc2ev9VIFrb3ozJoPLTXTZ4ZqHagDQPao=;
        b=aThAsX8w1ErtdUAbeKp2JD60296VSEmpb3eCUM2KP+jhdww6NSHNM3LiRpzRHjbzfX
         KRA/0UKCmVgalh8ygrY+IIOer81SPduI2PLwPnsYiXsYgLatwr4aFNugMJm0eieoKOrN
         6C2IAJHmNwr6keBVp1n7jlI/IMI5Grvc11EJAJRLqOrYVfYhRM1uZCwICsjWjQB0JwWc
         WjPzq5BfDI3q0vXmqsxtDJWoGm7+XW8Bj9sBESM5p9IXx8sSDXtnBXi2iffICsFxQiGB
         ZXQSrMEJVL8RwhEc9Pdm+KMFH1KtFGUh2r9p4/EMs70UVih0ngEOsP/g9+V3J+QFjHcJ
         UK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987624; x=1795592424;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V+Q/b4oQQRcc2ev9VIFrb3ozJoPLTXTZ4ZqHagDQPao=;
        b=RyCLFuCE57+qB3xLajls36ki3dQQry07LL4bY9TDeNbTG3DdqOODxLRvgr+xAp6t/E
         XMXhyK2HyuYyee523c/R2MzgxMRPWke93LEhEoFIhenFrwf49G3bgCMIwb45JQJNeIHo
         qqr/9XYs9t0Hf894URPt4H4jw8a3xgtpClurHIET6Nmfiv98a6SMwxGby8PuHEd1h6Wd
         5k3idlkOhP5lypOUOPeFeKu5msc0sXv7COU9xoT5YCEAoqu/5GAvNn/f2OuEF5Vnodrd
         Jvh+bHRIQ8Ct2Bl5xJaI7G4dm2I5z6TAxFtLu0enFIMr11udzVMKd6srNAxOdY1AsgE2
         +RqA==
X-Forwarded-Encrypted: i=1; AL+hErHTHQJ7RcWjMZ2YwEo7efmekK0FOCvTsyYpgECpUeyCQCvNZhiGRkcriK0PAL3RFcLYx6pJgQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z832BnpqQLpn2FGL0FlLYJVq0NojKAEK9UUI1wFvZj86NEb3ypI
	9XiwRTDQVriaLkPrC2NdgKfPXLXvhC3LxLN9xlmmm5N9oTpUEvwS6wa+
X-Gm-Gg: AZFdTZfo9PvG+epIAcBgirCUShJuu2Wr3pzP4YmD+t/YmfU047FsHJM+fqdRDQGPzJQ
	pXuRvf2THFKO3pQOTe7muJ+b5nNdGFdQcbsMH+vyOiK1EfE7wzc/j0CVKTCzfS36XluQZdNtiZB
	72JDIkHFamcoMkwMhANBlsDWbLhEIgHoJIrpVUFBne+94x72OuWM5t7VarvqFH9T+bx7KQdfOKy
	kPfODZH1uqO/ZSNN3LN8SyejlhdYZz1867CX9bCAWCyNOdi+Y6pbx/LYgTXf23rs5Q/CTo19jpr
	G5h69pmEDnLQUgx1rkfSVjaezwcwWz3YYUrXW3jVyzV2VLn1fUPYJ6vzN5wgUfRkpkU0r46FHRC
	wSP4xi0pxq6YagirLhXACPdHG8k2cQvom20rVXKDQ9+3EGp3gNskfBVyjYqO2YaYK6Yr2bej1Nw
	vOcTWjYZcpSw7h+qU6GaduZEcflWTU5ieSS4tXgvK9nFPGwJTW5dhdB4aJkrjtdB3Ec3w8Jumbm
	wRsNWdQBdAViumG+9uvBLQKfJ1e0XwrX8qVY5s+Ut7NIhAsLf4XMOD9dcWM1gn3weSGnAqeUd9F
	Favra2HT/H2Wcv18lfzcK2ycOWHg+fF4/ltZjeLqP3tbKTMHqp2Xs6x7f0/oS5vY8KYSIGTsnNM
	P3eXsoauWUhKzzufoh6x+3KkI8G98b0SksnJr980XQaYaV9Rfu5ezHS7XA/EKJA==
X-Received: by 2002:a17:902:d505:b0:2ef:e044:290c with SMTP id d9443c01a7336-2eff75451bdmr16959655ad.25.1794987624447;
        Tue, 17 Nov 2026 23:40:24 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6214565sm8667315ad.42.2026.11.17.23.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:40:23 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Wed, 18 Nov 2026 03:24:28 +1100
Subject: [PATCH v2] mm/damon/paddr: skip non-LRU folios as a whole in
 pageout
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
Message-Id: <20261118-fix-damon-hugetlb-pageout-20261117-v2-1-547a65a3206e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2N2w6CMBBEf4XssxsBRaO/QnzY0rWtkZb0IiaEf
 7eVhMczmTmzQGBvOMC9WsDzxwTjbIb2UMGgySpGIzNDW7eXpmmu+DRflDQ6izopjm+BEyl2KeJ
 eoTPXJ3mTHXUCsmjynFf/k/6xcUjixUMs5tIQFBiFJzvoEm3+OLvdeRxHtDzDuv4Ap29dr7IAA
 AA=
X-Change-ID: 20261117-fix-damon-hugetlb-pageout-20261117-a4e03d9d5a5b
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.16.0

damon_pa_pageout() uses damon_get_folio(), which rejects folios that are
not on the LRU.  For a large non-LRU folio such as a hugetlb folio, the
loop then looks up the same folio once per base page even though
pageout cannot reclaim it.

Use damon_get_monitor_folio() and skip any returned non-LRU folio as a
whole by advancing to its end.  Do this before the filters, the
accounting and the last_applied check, so that adjacent regions within
the same non-LRU folio are not walked by base page either.

In an x86-64 KVM pageout microbenchmark, traversal time dropped by
about 99.7% for regions covering whole 2 MiB hugetlb folios. For
4 KiB regions within hugetlb folios, traversal took about 1 ns more
per region.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
Tested in x86-64 KVM guests.  DAMON KUnit tests all passed.  Ordinary-page
and THP controls passed the 3% non-inferiority bound in the microbenchmark.

Changes in v2:
- Drop the redundant hugetlb check and update the subject and description
  as suggested by SJ.
---
 mm/damon/paddr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5b773012a876..0a205fa8d468 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -268,7 +268,9 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 
 	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
-		folio = damon_get_folio(PHYS_PFN(addr));
+		folio = damon_get_monitor_folio(PHYS_PFN(addr));
+		if (folio && !folio_test_lru(folio))
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

