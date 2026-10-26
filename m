Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013792;
	b=wj81qa2qE7wRAVGaii5NuAajh0AZ53KWesFI/X4S4V8Fi/y7yI50vz1y2YdDoQ7asHly
	 /uVl923UJXvEsLIFMcHdPK65uXMXTrYLu6i0clqRHVicLxtkVVEvAXxWwuEVigRI5W4B9
	 BDtL0bMxUZIAfKUdvJJwjhsWbLPVEPCkqioobq4hTl9iZPyNoieYVLFiR260vz0kFD/T8
	 ZW7FtTO7HT55zRE4qqxEPKZq3DChyBWf+kQPKgz4awjokFNRV5gJr/OleHEtMUq1Qkrib
	 kLE5qbLh1WFahbs9CneNcGdfBeQbEBo+/uA/kayOU4Y8PH2HlJsOre4/ChegeH5nkPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:References;
	bh=Pt4uKwQ2JQMqBpqG35YVL83bINioR+SmPDBUrwkRSWs=;
	b=msrFyl8YSA8A54fRydgTVupdUXKCCDZLvB6GplHCHQ2gDMxRL+/JIQ7dozezWXKyVwrt
	 s8E0rF62lWifCBT7jk70ATdLsWs80VeEMuUQIGiQsQHn5kHAL9DUGm7YO621mUb64woYg
	 2Em6LIyiuJ1rGfXhY/un2bMHgyxnOFPpGcIOot/FzMJGF+5QTA8FuuluFxNDg4DNesm+F
	 zMjvhSaH5ajde8smy+AcrAvJ9to/UzZspTiaWpeSPhfPzoF9UsclpAlc5QpQB8PlqznAr
	 MXbaFNFuzB7OewmBdqKYRELmbapkcixUXJGoHB4WFBS4pM3sx9R6VG0TpLxbbGxdu2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SeYQ5I3V;
	arc=none smtp.remote-ip=74.125.228.1
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3053606A336
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3053606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SeYQ5I3V
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cd63952c9f2so300982a12.1
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013791; x=1793618591; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pt4uKwQ2JQMqBpqG35YVL83bINioR+SmPDBUrwkRSWs=;
        b=SeYQ5I3V4dz7/vJm5zwyjOUHxcfUMFbD3EGDkPRE8eh0zBpa8FOOCs1YAIhI4Ips7r
         KZNP8YjcewNsB2MpG0WtgAwOZ9RzsiV5cGdxH35LCanZSr8IkPEwonySNLx96O1BNRDd
         bytnGu1+7a+A6ccwa9rFSCWpxL405sFd3jhsh7Qk9w7XXsmk8PcV6RZXe6iLv5XsdbY9
         31X7gK2KotsPy0txmXlXwPQgQR2iaQ1cVeyOFveUW/PGjZNAaXUW18nDKrm0KT+QrLoV
         879KoQUmJ3HBiow+JsAuFe3nfYiIeJwoJVUNiOYyReqVUP/ENbDt5zEXn3bUkeTjhrm6
         mrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013791; x=1793618591;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pt4uKwQ2JQMqBpqG35YVL83bINioR+SmPDBUrwkRSWs=;
        b=2SLXdaCQZJwBO95aZkRtzslsuvQMtwXrO6SD8sCr9Id66kRMnSb9aqd1pEmtvMCJXS
         OcsXZCtpE3aDIoRxrOUXlDLXYdiHEmBDRbQV6WtxaH//nFEGh53ljMB6CCyiu5AsUwfe
         b3DvChX4YP3iYSXt6M9wAN+yhvm/hbqeHWVRaRHUA9FFzCWJloRmndmnZwNA5E+iBlYk
         L4tkf4bTcW+E6ZHsZTNZIBfBDydxF59F4FrP2ofLf4fBiCoNp3vbI6MMmS7ZBY5WNygn
         trRaYvqOJK9RxIWdbSW1CYFtQoOj0zOhjRiT8AH7Hdxj0aqma4XNzHF6zy3r+DM3YT6v
         067g==
X-Forwarded-Encrypted: i=1; AKwUvByG/LSmYZ6KJht6IVXomUpSe8TPt8WGB47A0f9AKQb6/XnSte3BhxItw9S0Aq476IOeNqu3bg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ5qCfsXtuaXEWLnZ4+6FJHZp5vxnDwBn7b5ZT6thTongVijhxQ
	Yus9dtFY59ftM4h6e7QkbEyPO0B3LY7Om/rTj5erBrQN4Y9CbZskEw2U
X-Gm-Gg: AYBFou3qYQj647zF3EcMIQRNt2UPAhtH58kihtbc876jWk7NhBbHVyeTffJGUAORoz9
	IFfCMky7w550ieQ7AtBHRUvrDFZPaPZbzM4e0u15tcIGjFMWvqZb6bllRU0hHczRfHasNDIgNSY
	AWAXZdGhx2sefqJcZHmSqi529NTTcgwIBBGA3rtqb41FVqyM7JSIss7uZlqDnH1vXW+T39UTUqi
	JgLFrbgWYkMBPby1Mc99Zct1139yUsYPI2LTAcXiO9eSUXXQGr4oJ2ij7VywBs8JrIYLJeg4IxC
	fkhAOVsq8EpGybsMgTxon+xySl3oN+h0qb5VXOnTYASiRu/rlhBFmoqiyKP20DuW+QmB7vif4PD
	/xhkfdBYEQQIMcyfMqH26eOY5V7BwuN0EK4aWGoci/udVx28/NiXg0Ob2sk67IStlvOKnt9FTRV
	RXTnl4UYUdr3wiAAt+LU+GyVWp2ocKJknuDOHy45Nwow9rozGWVcqSL3tHmY22/lMMBcD6+ImV7
	hrFEBuzLLqlHUqzIysZ7H5DHlG+phZP2DXwE4SRWNHuxiEHqg4hCTjQd2kQMoaHoQ8GGYl8J1Pi
	87D0EzL8f+2RuR9W9MwJWF90qwneX5G/Go6l4qvJ3EN+Vi/gc4mFEw==
X-Received: by 2002:aa7:8895:0:b0:89f:43e4:8ac0 with SMTP id d2e1a72fcca58-8a367824c35mr4636851b3a.49.1793013791296;
        Mon, 26 Oct 2026 04:23:11 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bb2968esm1150041b3a.35.2026.10.26.04.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:10 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] Docs/mm/damon/api: fix verb form
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 26 Oct 2026 22:14:38 +1100
Message-ID: <179301327249.2.1896995843401183120.damon-docs-grammar-6@gmail.com>
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

It should be "All you need to do is include", not "including".

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 Documentation/mm/damon/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/api.rst b/Documentation/mm/damon/api.rst
index 08f34df45523..1f330429b486 100644
--- a/Documentation/mm/damon/api.rst
+++ b/Documentation/mm/damon/api.rst
@@ -5,7 +5,7 @@ API Reference
 =============
 
 Kernel space programs can use every feature of DAMON using below APIs.  All you
-need to do is including ``damon.h``, which is located in ``include/linux/`` of
+need to do is include ``damon.h``, which is located in ``include/linux/`` of
 the source tree.
 
 Structures
