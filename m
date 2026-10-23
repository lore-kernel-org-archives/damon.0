Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768970;
	b=oLCLM6XH8Prtyky+KSYDanOnUP8DdL/fA4Dl2hz7S4/74sb6ZIDM2G2rHs/S0IZgDMDt
	 EAoJME0jxjJP3o0a7c2S/krYbp57aJgNWhYq8We1P+mrp6oD4LSQsrCZxcAnRbyiSm1J5
	 chNrpKHNCz3JO5Md/7MHvtBF9nLhqvpqBLvj+u+ZVHpBZKQXZdZ9ATLdmM5BBY4wY7JOW
	 Pl9aJKOBGF0deGC5uveM4XApLDnkVPRJVFLq+2s6fd4h4taT3NkO9EX12aZXT/o0HpHKe
	 7swcmqGhyTQEilTCpdsdNbVJiOZIPwXGBqrTWM2C9i6LhX5GOTFhgdtv+dXl8lpKjNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=v4diYte8A4U+5YdamvmyB/opU496/bYf8sQxy/1ok8Q=;
	b=H6oHfriqQr0NgSPhjWWg5kd1iQugkKKRbw+Q73sz5njzJKDGPUNPJ61GtX/XFVX0p65r
	 gwfDXCcThkTzPW/k7zahu4XtbJ0RcW4u+9rZ3kadwLX8AElMUctk8yqo/BoEKsiVySRVN
	 TqvBr2zIg32YdwKJh73757taDOJhNv3cSXu8Edkx/BXJRAncb7Brd4kpJ9HAPfNteTIYX
	 ZulmmvR+5br74rVYwhq8hns3MTW+xB8XfJZJKXbm9LHUPcT7OTR8cj1Dn3+4C0VN0WyGa
	 O1PKaY2j2eWC0o7mfQiqh7muq+8nylNeCLxeggnQVxFIQYTJcFH9ylcCB49vB/tJAxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rfe2mDy2;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA0606A31B
	for <damon@lists.linux.dev>; Fri, 23 Oct 2026 15:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AA0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rfe2mDy2
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2e831901331so6690115ad.1
        for <damon@lists.linux.dev>; Fri, 23 Oct 2026 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768969; x=1793373769; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4diYte8A4U+5YdamvmyB/opU496/bYf8sQxy/1ok8Q=;
        b=Rfe2mDy2wnr8mHr5ESre0VXpMqTykAKjZwkVzTAmZh5d1DiNOs8sBd6bWcpoqh+xz0
         j5NvcFoV9Z1GpuPsfDF/Czd6QfxstjVOqttu/A/kTcwYi3xSghXay1g2QbUqz8Nwptv3
         knxiRRWmfy1Y9OYA2qt8ucV9eTSx+VVByjdppqp8oBak2UWXXxMArNVarX4+DJdGVlLz
         TLCgaHgZWKRT4XGKOQcnPRlPPPPcXJgyS8h7tnO7pUwNcsxTUu/XY3Ym5H3+lRgfj3/6
         H7IVHscqmQl26xiZ6aT5edjzIafU4EJrFl9BdyaFm1+G9yOMSrDc3UTc3FzbzKCtjpxU
         m6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768969; x=1793373769;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4diYte8A4U+5YdamvmyB/opU496/bYf8sQxy/1ok8Q=;
        b=lMQ8+fCFRU2+QAbZACGZ26ofrBVoNm5sjmP7Lic+kGzi0zTb6U4elskTmNgAjNbEgZ
         H6q3tjFEC763YTzDeV8JeahJcjxtxle0CwdjieWAwDcJ7gn+kO4S5L9zosrWU190bQ/p
         ccwe2vzBHdKgdBAX7CGKIBjyXcqD4UdOFneWPSx4RpLfoonQxuj5J2Ei5QO/ML09a/ui
         QS1/TY3qMq1aFVvAs9lSN+EHrxalEEkg42HwXdfGA9Ysmx9eQd4sCJfzzch3ObrZ4q8M
         /zHfSHoAD96G89/Gv7YXqQ5N7WgWrcgHPduQvdkCV4J0LJ2VIhmlHXxOSnMWiRi2u8oV
         3cVg==
X-Forwarded-Encrypted: i=1; AKwUvBz66lLHtb2IA19/+9SAjBxM/NzpkH488Hsq//5bGXW7NcjpRZfsqlFhLaxWd17lXXUDEgFQ7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYK/W84ZK5x+mxowYZbbslDXuOLdPPzcVZCQVBOMrkLYrDiOGOqS
	ivxPEUsUX/3mEa2V8XIkgbl2H6kRBPrIAnzkZuZ0ACfa20iKF3EJjYYP
X-Gm-Gg: AYBFou0YFgtKt5edii1q55GXWanoTpxhVez/eKyris24BXK5u+SDSNtwl1WU2c5d0D6
	Vw5hgtKKaQm+UhZeL1WVPbIm1U1v/16q0bTIKL+Qvoy/uQOpFYMUXlNe4WechR5v4t1z/YA1s5h
	LvsaDm/BocSikMXnMaQ3LpBMpHtcWzwEdPCtr7sDOQ5wz3aflNB3UvDSzbAtMzqF2da7KZ7Rv4z
	GF2CjHvQhvL6ecYR3G7264wK9O2AGcpZUjr/ipCTb+sIiBlmSAM6V9LhfV0P+CRlZxez+E80Bpr
	Nv4q9ELsDxmmfzMRc+eWvwT0lPMWqktY1wCOY7BJWilry0mtibVTno/oifm6Wrgud9v2MixhFro
	BofjKpFqy22eZer6lUNtQ4AxxeE3J8mo4u0obZKbOVe0aeZPdaVqeIzhte7b9u3AX899gv44Wb+
	0MZjsPA5DQ8xLzE63Z25l7yK8t4eALRhu3lMhvZwpSP56/8CR6JkxaACttnKd1g4mv7CzJuOHf1
	/AO4BofNW3+alTqOcwu0e0BHqq8mt8jmnhymYG6i64YL8mLcXV5s09vexIkt9Er2k6PRm81D1co
	qKz9hZCn9HYPvoeRuqwDmIcZbj8yJqO6qg0qRNWjhCAsRSOOVTKo
X-Received: by 2002:a17:903:1585:b0:2ea:1b9b:b946 with SMTP id d9443c01a7336-2ea7d09d3bdmr25679205ad.14.1792768969109;
        Fri, 23 Oct 2026 08:22:49 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9476f72csm1528235ad.43.2026.10.23.08.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:22:48 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shubhang Kaushik <sh@gentwo.org>, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Fernand Sieber <sieberf@amazon.com>,
 Leonard Foerster <foersleo@amazon.de>, SeongJae Park <sjpark@amazon.de>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 Christoph Lameter (Ampere) <cl@gentwo.org>
Subject:
 Re: [PATCH] mm/damon: align MMU notifier range when clearing PMD young bit
Date: Fri, 23 Oct 2026 13:01:31 +0800
Message-ID:
 <179273169185.2.1655708299473876346.damon-pmd-kvm-reply-draft@gmail.com>
In-Reply-To: <20261023002018.102560-1-sj@kernel.org>
References:
 <179267916870.2.5637290691657871645.damon-pmd-align-draft@gmail.com>
 <20261023002018.102560-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi SJ,

On Thu, 22 Oct 2026 17:20:17 -0700 SJ Park <sj@kernel.org> wrote:
> I Cc-ed them.  Please Cc all
> recipients who get_maitnainer.pl is recommending, from the next time.

Sorry for that. Maybe I will use b4 next time :)

> However, I think this patch explains its context very well, and therefore
> this link is not needed.

Sure , That make sense.

> Were you also able to confirm the expected wrong behavior (missing part
> of the sampled huge page and age secondary mapping), too?

Yes. A test with nested x86-64 KVM confirmed both effects. With
4 KiB EPT mappings, a midpoint PMD sample left the first 1 MiB young and
aged the next THP's first 1 MiB. With 2 MiB EPT mappings, both whole THPs
were aged. After the fix, only the sampled THP was aged in both cases.

Thanks,
Aveline Noir
