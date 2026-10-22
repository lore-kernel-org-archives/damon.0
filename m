Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680147;
	b=YMVAo8LwvtOEQLRLambzm7IiCpTsqb5Fs3kJgWU1wlqzEItqj0/P7zuWVrWdctGq4zvZ
	 iMmNVm7BudTtT8RElLEnq+z9kA/3DRrTqL6idrYx26bHfQ9ni40AZXb5xr4BSF8H+VXEl
	 2bVuR1dK/w4Kpv4qN2wKKc0ulWfYkUegoEGsGL97EczqO+nFsqvrTSsyy5gnKEbcUFGmC
	 pX17xwTuDTxK7ahEpVEEZBnDCW//lVu/6jJid4yUnKL+JZHw3n8s2LOZIEFuThJp6NfRb
	 4otnwtkDXjomWQdtntZQ+saZYRv+IYDxUNoWa3XP8XmoZh7RUgKKTD3b/hkdc76dHOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Date:
	 Message-ID:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y2wfDpQE4IPV/6hlJzWhRkXMd2sbxqFFifw6+/5xT4w=;
	b=GuN5awbcpjSTZBCLCkeFoik0/SYRFIm0KceZJdpaBuPZHrPsGIsZ1BdLEkflMoHj+SD4
	 3SdpSBZ5B6cQkDcrMHtnNn3qd0pmMXcIHx3An46uP2c/210PEM2B6BR9v1Um/UNX/bNUW
	 wltUHI6wMqEbLrxcarrVPzVvnGl6vcjNs6cmyTOsGNPo8bk/Fhhbi/Ywpwh6KNDaKKn8s
	 kKTWcQ/9FPmg5Gh8DdQYJQm9Sug9rIq/uXXX/EiCgxNEwsGVXyN8t0hVhzqKVy7Ozx67r
	 +rGMhJ/zvPJjhCaVRsjrMF5Q3SNgrBGCRIANPWRTtLeEurv/uGfm42sxjv1Bmh8KlMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SFGi6vTu;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE3606A31A
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 14:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23CE3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SFGi6vTu
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso2786749eec.0
        for <damon@lists.linux.dev>; Thu, 22 Oct 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680146; x=1793284946; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:message-id:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y2wfDpQE4IPV/6hlJzWhRkXMd2sbxqFFifw6+/5xT4w=;
        b=SFGi6vTuv4H1BQaoJ/Eb722iVoubKA39raSqZf7xjLqyGGDljT+uuF2gftnUhf5YzD
         KVF4H9hUXvqpZOe9DNqrfCOFQAl8JaoGxtRRA0kHsvBINsbdrwyfOeVz9IUyzWENtTMR
         +CIXM8Css7QTsVUeKw0taq2qALsUwZzb9Ok/oa3FoWz/QRYxi8TFSLK5HWu6qGrzg6pQ
         +ECAYDbPc+puHXiA4mC4bbkYEcdfTiMXjNG199N91v5AFBIvvb8d1nKwqOWUWax0B96T
         RmT8JbILUQwgyxzPHcxnDQdF2teWTgnGRVsmp0EmTr28MpUybir0OxaxVTaeHFMLd85T
         pLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680146; x=1793284946;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2wfDpQE4IPV/6hlJzWhRkXMd2sbxqFFifw6+/5xT4w=;
        b=OUzDJmm1IsXSTUXZ3VV88XZJQMfSbUs1CVZrlR4jXKR6fHlA0JseKyQC8FQsbTyTHE
         xWQnLYCvcXw268/GzgkT3ZCECVIru8oASNn5GXb+/eNOJnmsYVHxycyS912B4zQEzuE9
         5FwYQ7rtamyDEXDZ1GLKeqrnT7MyMqRH2TXs1GVYiaXkTYaxAw5KhFZHs3vkBoAF3Kuz
         ma8KE2K+TbQmlma7wRutC8XDxG6za04tlbtcD107esV5FpkPytrg3otFkccUAHVSgkj+
         FaW7dpKG/qL8i7dSxttvfYJNCgU416R/TGJUe7r4VUrZqxlxfvCmz+mXCt4c+f6K69tA
         nlcg==
X-Gm-Message-State: AFq9FYK+4SrXVNE0UvUBJMCvoYwvS99a8iln0NKcARHqDjmWFJtOqHAH
	WdSlUZJrPw/8jSJGgd59tDEgYHnTTkT8HOzQeNT6NxIQfQ0tPiDY2oVU
X-Gm-Gg: AYBFou3xyVRS3U4uOB5Q49fxKaaoJ2vx7MVCZVDMF37Bn0gGFpSl1ZkiN29jiiBFucD
	I+N4ytXKUs+2VHylyphSV9rVtMut6szhlcwk3v2UhtF+l9sjE9EwsHHZdUwQQPy4HZVD5xxVR3j
	hG4WzjU6+2nvR7LEE7x+9cYdwLae1P1GAGz9etov6bSwsnMW2OTB/o+IzU/Tuf0r0POKEg7q/5o
	xE/4quxcV7Pk6n99us+mrE8ZJT/ry2XgBGToJ4FQY/9qK+VUh/hPg1A12RWwu+tmB5TGfa+uEFr
	dToDGl1vFw0HBzpE5Qfk6BKJafSGfazyOVkLcsFT1vKKAm4ZWaqEXMyL3r5EX98BhGcra5vBPEq
	Gg+q/Bhi6XsU3/fJTkk5PS8ODF9/ccwqZnA3djIRhwNXTRBj+74O13oSYAmECX+HSBL7NNgX354
	M5hpcfPE72ZCGsHlW2tyBxMVhqc7NxtpGCGUhe9jKehkx7WWOyqOaDsyI+CvLa7XqiBOoSkLYiS
	0/eqmOrzPwRFGrsgxMylJ7ZQm7XQ3IJgh0zVPv4kWdiijIM6Gvuj+SAzehfAC7qPyr+eqtNfStx
	fJb94j7hRASpu96/uvH8r/eUq21TdPMZlh3bXitUcvEQBI0yS7dlS5esKYzJc5y8vRLB7JUCke8
	=
X-Received: by 2002:a05:693c:638c:10b0:368:72f0:353a with SMTP id 5a478bee46e88-36872f035d6mr4190014eec.38.1792680145876;
        Thu, 22 Oct 2026 07:42:25 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198e2d6sm15218724eec.22.2026.10.22.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:42:25 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>, SJ Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fernand Sieber <sieberf@amazon.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 SeongJae Park <sjpark@amazon.de>, Leonard Foerster <foersleo@amazon.de>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 22:41:50 +0800
Message-ID:
 <179267916870.2.6178717610514277514.damon-pte-review-draft@gmail.com>
Subject:
 Re: [PATCH] mm/damon: align MMU notifier range when clearing PTE young bit
In-Reply-To:
 <20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org>
References:
 <20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org>
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

Hi Shubhang,

> Align the address before both the primary PTE operation and the
> MMU notifier call so that they cover the same page.

Looks good to me. Tested in an x86-64 KVM guest.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

The PMD path has the same issue. I will send a patch for that.

Thanks,
Aveline Noir
