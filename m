Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875592;
	b=RPgCYxCUGpSiaI/8qbpSgsdq/ktnbrgrLcbXbMUDvHM3eCbKm7juqEUkIWwM1GLxeazb
	 rYdRkgOt0szhXncCG8u7ikKD0jWQuf6+5QsDQFQBLojdIAdAYVLxq8i/u4Cp7pGWd6KEv
	 V+DSBrHO/RidegepWpPjp0ybpeo6+fVjp3WjlpI3x9KfDSZufotuj4v2/rk9WQ85Z2cmk
	 Y2RDWRs92do93gLjDdcQG4ZOZoKluZrzJpNFl5EbFutKaSjCUGX0yGNoALBbCxhDxQLHb
	 LgS1J6OsTNTd7Vp1ClJHMW2AEeWDTGMpE8m6OvvUNa7U8MJ8j1kp3RM94EbJbxQUFlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875592;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dbZu9LhtAY9fAB4M/fShiLFpFkzD+AOHvT8BfiKRcMk=;
	b=ZkJThnh4hvAHiTFtpOYqohkZaA61qSNPlvNi1EuvMS43twbN3RnWv6irLYU2bb1Txpvk
	 d9XGIoGLe6nff5VLPYbQbIyQ+DhDwRB4xePOtRnH6uTWS0a7iy9FxGn90jJyC+SDHJtiE
	 iwzi71PIVkZdxZJ0NPilB4TLlrKFS/xvkrrNMBQwWml4yzKSyVJMzLl9XBB9ZFvz8WOiT
	 GyHwCCWIamj75slOAMzDiMvnQEvUpeMpQ69q0+XVmliGH6RUXwLY4XzEdYXBZQf0hTFHE
	 M/D7TW48iqP5ebGQmXLnQ38EDJ58/m/ThnTT1PKABrPYKrW2JWQivtUp6ltFOlmwm+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GSalBFN8;
	arc=none smtp.remote-ip=95.215.58.94
Received: from mta1.migadu.com (out-94.mta1.migadu.com [95.215.58.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEB606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 14:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFEB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GSalBFN8
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=r3WIVml6i03PpVxPUqPo6XvC72P/NOx2GbY9IUuQQPo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795875589; v=1; x=1796480389;
 b=GSalBFN8yCpldYRQ0fjOVUqFILKRC4w9Qye8owds2C9oYpOXSB5sK8oBtCFrH4NOOcoc/27L
 KGHs8way/vi9yBhrbTqrfl6djxu8NgVXnqzYUQNP2s/U8CzQt4I88GwvnzZh2B8vnogLLbWTyDj
 8W8Jnvj68QgtLF410f64AG3w=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 492dc661d09d12a0;
	Sat, 28 Nov 2026 14:19:48 +0000
X-Mizu-Trace-ID: 492dc661d09d12a0
X-Migadu-Flow: FLOW_OUT
Message-ID: <c1722b36-3adf-46ea-9ae9-b72de998f9b1@linux.dev>
Date: Sat, 28 Nov 2026 22:19:40 +0800
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
Subject: Re: [PATCH v2 15/27] mm/damon/sysfs: add filter_report_type file
 under probe filter directory
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-16-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-16-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Add a sysfs file, filter_report_type, under probe filter directory.  It
> receives damon_report_type from the user.  Reuse
> damon_sysfs_report_type_name struct for user keyword matching.  Move the
> definition instead of forward declaration, as the code change is small
> enough at this stage.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
