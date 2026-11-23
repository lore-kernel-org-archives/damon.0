Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455390;
	b=rzGLPwu3j0D3J9SurxEaK/gcwtJG0qFjexZHYkDcTQ2JDxpqgNNwqkUFbkVzN1z2i0aR
	 qLpwy5Mi+UrQ5xOYVIYDdHzmkLnbGNg64yfPq/3HyhfGLs6/kJkGdtClMdqkdXoPfk96T
	 xWA8nc7KwlJfIGwef5Jyy//BLUSWpl2Tnk2tHFRZAuDfbyD3r1AYFSkpRVuoH2k2PiHKx
	 D7cKM+y4ybviUj9gODvjUXB4ok1B+u3NEy5LJ7M992kJpeS1yw452vsKj7VyZ7thVsD6K
	 SWsPCcYxCkRBxfqx1AZeENRMtttoW9xOHys/vNDMePoeTN9iO8AhLiJn5Ft0byldmPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=G/aUT5PBmLZcyNJkQoSxFcXbcPE5jdOsaYBnBQfYlQU=;
	b=aPUnLjACK5Ow0PlnJFBU0mbinF1NwhwpQuda4kQkHuHa8V2HD4rlE/SG4OHxwC1DFOcV
	 /lP3RKbUmLdFV11rpvOtd+akdVi44FFoytvI30hNU/1ymUI8N86BGOLNkhd9rAK9JVwEt
	 8lBOoRAHXge36ydhYlKjVZLYTSd/uwQVL7i84C53Zcw12idy0SGkjJitL7Pves2FH6QH/
	 ZoLZU/iNkwayT1Ig5bQiwjfkYNzB8EP2dw1vC3B6qAv12nsbnEt+Cx0MggGs8zsLRKGI9
	 v8p7uCdXi6+Q0afxpIAO5GwTi4SSpXO72NF7FbGT3JPcKIlFh7/f9Ou5p9Tsbr56q4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UH7SFw34;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03A606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E03A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UH7SFw34
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3831d564bcfso1418759eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455389; x=1796060189; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G/aUT5PBmLZcyNJkQoSxFcXbcPE5jdOsaYBnBQfYlQU=;
        b=UH7SFw34WD+7jaXurn5SwJ6pHU1gAPJvSwSw+Bhn4CaQnPeYKvoqP1dZH67q6aPb0/
         CKeNXrZx8grkbV7jZ4fwQ9Lwqyk6LFO1bJRG+StC6tAUA2Dvlkc6NljK4+1wlExsREuJ
         bw0datCR5te2PiJsPzL5ay1PKtk0lowUAlbCtT3idMZaeL+uCsNr+V9THzDNGLrjOMCp
         +JhYigPsFySBqDVi23bq7VbgMg0Cq9AmL5pKLMv8li8WSwm0PH8r4g3vQLAb3PUlr7zF
         NN4LUre2aYrECq2NwUExU2k7ZOOQoaw/Ar3mT/CwVeXuBFmXcTM/vAZGwAiAcMqzs7BG
         4AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455389; x=1796060189;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/aUT5PBmLZcyNJkQoSxFcXbcPE5jdOsaYBnBQfYlQU=;
        b=xe/MJMuRgT+8r84JEl8ygS6enET0UwoqLSnF0ukR9HlK46zBx3AN4EbHzuifUwZCk/
         PRwI2ue6ial64OC8MrZdRosQ0yWH1x42tAAeQ9f0/MArLx8yUD7jNxCSsrJJ2hxSE3R7
         VwhFmc/NftJBHK17Kfv7DwCjO0kWaRy2h1FF94tWI2Nmb4yckhViEorDp6ZoWvng31re
         gj9ipiZPwMuv6iwAugDbbMFJZH37q/LJcmScylunHtE2SJcCpaj+3N3ITilui5QUAmCj
         9pNqKIdjac7Kzuwe4VEESasQQeMU8QO6hy5/Ww7wdoGpo6bl+ES6LLf0TBnqK+mc3B/R
         /lpQ==
X-Forwarded-Encrypted: i=1; AL+hErEk3/7d4rciyoe4Gm/8BpoxIgyip+7IP43PnXZhrVLTbpAAw9QB//tx67c32TK59DzF+vL/ww==@lists.linux.dev
X-Gm-Message-State: APuU4Z9gc2sNzVCg76dm3GwPfI/jMZZC6JZ1RvwR/e/djVDeOEtUa050
	MYgbbhlBvynuJ3V7UdrAYF5u+iImAFiFh0izTw904fX71nSO7fW95z7g
X-Gm-Gg: AZFdTZcIIfTWiNGTAKvB6XcEKR5rtdfE8LB9wpZlKG+ZBuNhvxMEczGrS1kgZ3hmD2H
	imue1OOha6BXpdxIw8MhD664EsiBeqsnBQdeR1oXVEqs65WYW0iyjwN6DZbSJlZm9qhBSiny8Op
	jbKnnsBZ38+mk3zoPUvMJrxRpu3jzOwZ7NLv7x8cZaO/XOjMDyUpuh4gqm7obgdneP6FQjNjafs
	eSZCVFYACU5NWluEjaK2I/jspmg9gdVvj2f/BYwCLo+SopJT6mAExxJZ5PGVDiSOY92vJIGjo/R
	E9t/SI7NfPtkCiwryAQ8b6cPfcXDpEKZGEC8UhBd1M2XY7WZcXuampuFreEPRI+IIFXCkBQXaSP
	cvjIk2S18Er1r0j0O+Yp5vWc2bvcKeZXwRRz9zxjtR2Ie5n38T8jifGBXbIPXFYkHITg+4Ods0j
	MpGC9sfCK8FNIaK+lTlpwLGq2Ec8gyIeBmm0Go3FB8GFtPLpjIs3biFuAAeQs4vjZH+0AdiyAue
	CtySvx5qiu/hM/st2e39JMIamfBR4XtO+tVDlNrdmZNjH7oiz0L6N2PmvA2LLk4qRcXGbhjlaIw
	89JQgK9w7kDNBkumuemsPBql8UtcmrgQ+qUX92M4PHnvdF7Gf0mATxIhs6mZvQj3iCCkZ8SadUN
	KnjteiRWD6k7BIfn/XGSQfcvbw0bAwuCknhbTPxsAu8nfeR5UZ487ZgBG9C+xtg==
X-Received: by 2002:a05:693c:835b:b0:386:b5ad:b719 with SMTP id 5a478bee46e88-386b5adc3cdmr2651925eec.33.1795455388511;
        Mon, 23 Nov 2026 09:36:28 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:36:28 -0800 (PST)
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
Subject: Re: [PATCH 09/27] Docs/mm/damon/design: update for report system
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256500.4.7925013692568446528.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-doc@vger.kernel.org, 
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261121210013.130397-10-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-10-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:53 -0800 SJ Park wrote:

> Update DAMON design for the data attribute report system.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
