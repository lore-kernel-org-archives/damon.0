Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658989;
	b=tYYaOfAMsuon2L3fpHqaxNgu20PgJxq2GfYk9jKX6sZGEp+hjs7OpbzJ0IzPvpKN40eg
	 iiThdZp1R392H47V+VcD/Uzojn1ZVFCzGlMKPWKofXvZM0sTluWAM7+IpPgncDsTNgGPT
	 L25ok0uJvkgGSNjaB1Nt92j5ZhulfM+xncdW14NUQfzlMYkTyTmxVhI7KZfgVzPx/vhm7
	 Pdo+HCeaOlykOOslMZrRbStCm7AhKr/c4jA1fMkx0+cRZEg+UQpZgrNBx0RwbySmHBodz
	 6Vk9sToQX4PB2sUSbLEP14bSgfn0CCcCKwP5KgH7iCcqd7g6spL3spsnbmLYF9STNzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658989;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QFCJnUDvI/zg1+C9IEAmU9f3aSLnc5uju1bEjEaUAKU=;
	b=YINKGu64MKKVCQ7XGn7M+2NzY/qJIv5m5dipw7tu11FeGA8OvpXyxUMa/g+UKZAdZS1k
	 rSMA8S4TJlghiIeMZsB64blsrj+2E9O89melgLz123ZI6NDtu81eGNGiNEafHsVF3R5dh
	 rvdhkM3q4iVaETpT6ktJiwYS/DsXSAl7tU7gnukOBFixz1WVic4d2G1zntoSOP/ZMjPZA
	 MmVGTbORJcn40i1BLPwFagstuYBIcphB0Dh3H7BpN6lXiODuoQHCeLrSQ/SZQhe9GYCg6
	 IzAa/AtKYKOfgsj6976J1Yiekr4AHmqo2j/hVAIArY4644lHnoGy0A+65eWvFABkv+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rMsou7hH;
	arc=none smtp.remote-ip=95.215.58.135
Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F0606A31E
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 02:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B3F0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rMsou7hH
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=iPPxwdSBC7SlFa3kpJ7q0c07VmKdWjj/7qHY2bBVFek=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795658987; v=1; x=1796263787;
 b=rMsou7hHxIbftKxzemcNQukrZeleDw/BRhARpk9a8XZZK28jkPvgbHPqPjmCUjCiQJJlDe8Z
 aPeaS6XWgB83cC96ZdAnQ6Rxyp806lwfvcnkROSTVe06QPa+TSE3R9qIyB8mMmri+ewLo6KMTBA
 uZyfBFtC1Hi8C1FEodIdr0dc=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 3ff17c68b4d8eade;
	Thu, 26 Nov 2026 02:09:46 +0000
X-Mizu-Trace-ID: 3ff17c68b4d8eade
X-Migadu-Flow: FLOW_OUT
Message-ID: <842629d5-974b-4987-b9cb-0f0792e3d69b@linux.dev>
Date: Thu, 26 Nov 2026 10:09:44 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Enze Li <enze.li@linux.dev>
Subject: Re: [PATCH v2 02/27] mm/damon/core: implement data attribute report
 queue
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-3-sj@kernel.org>
Content-Language: en-US
In-Reply-To: <20261124153636.91854-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Implement DAMON core internal data structure for queuing received
> data attribute reports.  Initialize the queue for up to 1,000 reports,
> inside the DAMON init routine.  Destroy damon_region_cache and reset the
> pointer for the queue setup failures.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
