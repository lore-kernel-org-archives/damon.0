Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435226;
	b=ySaMduN+S7qQ10v4Uk7rpdwDcZDMvLwBw2yJZKErvJpJV14u8Ky1lhX5VRRFxpNYrr6q
	 DtR3kMFVaUl2P1slT23YyfvSv0tz/ctQ4B3OnyLnb7VbFSwinlLpInWzO8YevrDUfERKp
	 Me93kPZ03sfo5vQmc+NWgBzoZD4lfdEzkcDQgHBuJA+0gu+dulaYLwoyR6F1nCb/CuNKC
	 6gr3Urf+oWU0vg0DzsRkovskKJ7IWfMvpK09KSKCxSvEioXLP/v0KRM+GX7lX3V8Daqnv
	 zzELEk1JsuJvkZ74wxAA8h5K7u70GU3meA47yydAc6TLhrNNuaz5gMJLqhmlh6D95QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WxKnM1ul0ML8veBKEiR6EKGxVNt9YLRjn30MmZJovvU=;
	b=DND/IK/gGPpOCgH4UGgH0PTbfaEzpT+1E+Eyzsy0H+s7WmncPZX6qdsgqBRD0b6u7qvS
	 HxcCeDbzDOx9htVLq7eaReA9NFitL7a7cYo4uc1iT1mnJhTcenix8oymQR6kVniVpExKc
	 AqlKBnXZy9MgvjhktrAhF2yAhabRz8UnKCPX3zELWm914o5eynae7CIYW5qsrVhUvOLuk
	 4mE9PVna9wyVY7hhAo1DUC8+yrYTd2fSvp8WuhvLePQumDaIZUJ3kHQpAy3pZvKg9BmwC
	 Ve09QYEUaCLN/wMI4foAcHr/SNH2HGI46pei+IgrNNvz42nVfMorIQ2LSQfgP4lKkTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EaBUbM6v;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1292606A31F
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1292606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EaBUbM6v
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso6930141eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435225; x=1796040025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WxKnM1ul0ML8veBKEiR6EKGxVNt9YLRjn30MmZJovvU=;
        b=EaBUbM6v4MhnYbYZax41Ajlnph7PiZ+dIreqTAAG2rvtM6H9SmPH1IelxAuEz//rqV
         WLxdDpSOlIDhwEiP2eIMaeQzhOLOY0TS+fnLQpSLRCTng/NPs8e3e7dwutyUO9t4uaRk
         gtOrP59QGGSxzGdInKhwzqlVb8xurMgsHRpoi794Di/wWubgpFETw/Q+dBZBD081rlvL
         3si3JzRWfR+h3NjNhnKjDnj6qdmNzSRLzYFnZQauIWAcUATKnIfcCNdO6/bY9PCwK3EE
         v9MeTUyg6hd61TDsR+RDHWRiRsoK6YWLTlfSRtwt/J9ZdE/W4ljrCWJlch76tDJ3RpM5
         NC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435225; x=1796040025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WxKnM1ul0ML8veBKEiR6EKGxVNt9YLRjn30MmZJovvU=;
        b=v37H2P6WwJt/Vn1FNpQyXKsmejX110XpVo74JnoY2Rz0XHjNEZYP/VkvszFAps9h3i
         Dg/hHQtYfT+rUnabeNCZg3YOGzOlcT6R0iJU2ACy4V5sUTpO4T6o57mj9Ttm66vj4T16
         rCB7TbSvH+XVRNOGriHeErNL8dNm1cDFWdfND4qmm1G7rNZvkCSWRQyuDn5BGTZt/+4v
         7YJfNSisrR60oqIalGkYww1ZTwXmGk6ZsUIBNKl9rASzqJKveTVaqdP3J+b8u6hBK4P0
         NGfNr6dSIANDBVQoCgpKVqD71GydJDk3SBTv5yAWIObFdrbUdV0bWtHDaHKqSI2iAODL
         4ISg==
X-Forwarded-Encrypted: i=1; AL+hErFjrt1UcAH2LMSoQgLREbA3qIZw8U+G6tBrQjNTtSgmrEAoeDab4Id9rFmcE5GcdNqhQXkEag==@lists.linux.dev
X-Gm-Message-State: APuU4Z9zxPzVfadwDOKNYjZWiwNFXGvXogYjJMxsYeyBwBrlzfTa4REK
	+UY/92wv5ZY84ORaQjRvzwcH3tS/yeAhuQE9uqnfkN4pY3LU4YeDpEZ+
X-Gm-Gg: AZFdTZePbJG9L3oyvKcNaCrmDmMaBUQSAJj4PT31D5ReVDYyGMCUS8LyxpDiAHFURm/
	YN8qY/rjHZVlKTiPXHwha3Sl/bYbNL00Eqo4kO0Ng7f8oxupRfnllwcqUlu8Xq/WRIX+WaRD79u
	76yGbzaR7DA4ZdrY2h8kH3oLHueq8+CSbssR8Jpqt+Xs8QBWFhXdwzPEN0vw6uQnA1WuHjN6TO3
	kWVBYBMFOTRO5yElISGc+kLzzSdSR2WuWPLzmHkNDdq3cbQowlildrDQFBm6WxHCb+FWT0wmZMZ
	vp8A5/2nP+JvFvwwTRteGtsnXBGDco7QU7ISkHrWFGdtdjnDBTO9jMBFvvizLq2TJrLus8augZo
	YfXRrC0SXqGiqboP6l+5C/+fAD7DF4nuOXwlXSjlVch0qSChLStXwG2eZdVpTlwixP22hn/W7dT
	ZfeVmacVBvQ5vFliZaQoDWmV6UfhPhiNEYQSQXHuCFytdvN9PVqpHp2UYrpzZXW9T1P5PXftRTV
	sFrvRIlV6NthnyrFm9qdsUub1hM07Ksg1mhbDSlSzOMj8DSeiwY5usj59I3sLu0l2jdlvAHukAc
	9YNJGT82HV2uQdR6pyNCcQW3hSUNzJ6AnX17PNjpNcXsNB3XazoSGPv790FsKYlnSPfJ
X-Received: by 2002:a05:693c:87d2:10b0:386:b5a8:1c5b with SMTP id 5a478bee46e88-386b5a82496mr1759903eec.18.1795435224684;
        Mon, 23 Nov 2026 04:00:24 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38577214c2dsm34869289eec.17.2026.11.23.04.00.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:00:24 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Mon, 23 Nov 2026 20:00:02 +0800
Message-ID: <20261123120009.9120-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121211922.131352-1-sj@kernel.org>
References: <sashiko-outbox-227387@kernel.org> <20261121211922.131352-1-sj@kernel.org>
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

On Sat, 21 Nov 2026 13:19:20 -0800 SJ Park <sj@kernel.org> wrote:

> +               addr_range.start = damon_pa_core_addr(pa, ctx->addr_unit);
> +               addr_range.end = damon_pa_core_addr(pa + 1, ctx->addr_unit);

Hi SJ,

With addr_unit=4096 both endpoints round down to the same core address.
Could you fold in the change below so the lookup covers [start, start+1)?

I tested this in an x86-64 KVM guest on 7d1a16abe4cc with the series
applied and the report timestamp taken under the queue lock. I monitored
one core address unit. With the conversion above, a report starting at
the sampled address gave 0/0/0 hits across three snapshots, twice.
An enclosing report gave 5/5/5. With end set to start + 1, the two
left-edge runs both gave 5/5/5. Reports ending at the sampled address
or starting one unit later gave 0/0/0.

The addr_unit=1 end-to-end test also passed. All six report-queue KUnit
tests passed on UML, including the timestamp interleaving case.

For the series with both changes applied on this base:

Tested-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 00865cbf01fd1..e276b91c54f22 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -160,7 +160,7 @@
 		break;
 	case DAMON_FILTER_TYPE_REPORT_MADE:
 		addr_range.start = damon_pa_core_addr(pa, ctx->addr_unit);
-		addr_range.end = damon_pa_core_addr(pa + 1, ctx->addr_unit);
+		addr_range.end = addr_range.start + 1;
 		matched = damon_report_exist(filter->report_type, &addr_range,
 				jiffies -
 				usecs_to_jiffies(ctx->attrs.sample_interval));
