Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749030;
	b=IZNUYVBRWDOAeUzz0dUV/dj5f5pLOphWQHsYaMGUfjDRCqgH2Tmlv5tHYEdaNzRZvb2d
	 xhx3F6WwbM81lMhQcefhac1yS3L0uGlU4I8Xu06RoPtuqy0a8IRTBwtitSQWNgL4jSa84
	 IxcCb6tSdECF8UwlI2RAtF7gvCDKKDKSDgkmzCPU0KN2ikfrZpR7zciOrWmhzek3sLRDR
	 F75+qzjPTpIw0lWD9pWEyigxY6y3JAFTfofu/yhSrjzcpj4GaOhHIHGgz9k3F/NtD2H+5
	 9UBXJFWs2hU4f/mCf6rJS+c2QvTYDaGTSIaiFreyUchEIlaISJXO+wOZR6XFFmty2Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749030;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=nbzZRC8GZ/f3CACyJdYhK6Qx0PIpPkYatenSOSwlUi0=;
	b=2XlVVeD2jEVieJyS1+FUdBIyevcvkqZWl2/bT9wl28DRaZNJMlYktTqjUdMf2dgF0x1r
	 vqo+XyLRDdT7WqjHEVm/k3F1YXqCpt7Hyo9+dbiVSzjQtY/4Maf1A/mdksBpG+SZrD8M+
	 XFrt1xM9ZY50fHjjFgXZQwP3yWIvORPPfy4Rec7aYDbHvdGh4Ex1sQCiuMsyIvv6BZvWM
	 FLl4eUNMH5Ej40XUogD/RPDMBehNqQzsNazPWzPCeqHpTmPjvXkd+vcncRIP0XhrKeQsk
	 AUXyU8Cdz5DLObST4eo8dBmk7paijyLcUSGULGE0RYOkkP5u1mRXnwTFu6giZ9MvXzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mtaOhat+;
	arc=none smtp.remote-ip=91.218.175.228
Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD74606A330
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 03:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD74606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mtaOhat+
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=5Gapfe3JePo/kAodLwmJ/LTyHDjI+QlZE8NLOsmgOt4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795749028; v=1; x=1796353828;
 b=mtaOhat+tmGIRwpphrx3PT/wwZ4ZKOXdVuSnHJYeMyr8vlSdyK5tx+7WOwlykHBst0np8Yx0
 60dhuwPTEG5WIxEJQM1uKf66sL0NCQLCYGfDzwWc1/RVzY+vdG51v4mbbW3uNetmh1iY924yrAV
 GUMP+CDxa/7GchdbLy/cARSU=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id a204e3fea644232d;
	Fri, 27 Nov 2026 03:10:27 +0000
X-Mizu-Trace-ID: a204e3fea644232d
X-Migadu-Flow: FLOW_OUT
Message-ID: <d768efa0-60ff-4f87-aa2d-07bd49a6c150@linux.dev>
Date: Fri, 27 Nov 2026 11:10:11 +0800
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
Subject: Re: [PATCH v2 11/27] Docs/ABI/damon: update for report producer sysfs
 files
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-12-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-12-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Update DAMON ABI document for the newly added data attribute report
> producer control sysfs files.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
