Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684397;
	b=mtN10feAhN0X/ripHy2rW716IihifP4oZn++YgzML+tHW+6Az9xrCCCTwsF5xZOnjon7
	 RXjakTrCDUovxyy2EmEeJD6sZ91A1XRVuBo/rXUhcHcBSQw2MMP+hbYAJ9h4RKB6F9sEl
	 hbb2EqEWr+NkNSKBdrY20amfo8PnPiPMqcKEc9/vsHzDrWaQM1tGEryCi/+Bwk//Yz85O
	 rPddpO3aGhXQorw/k5nw6YvITQ790POFWRpm2mwJoy9sjFn9i8BWxn0Pc/hAG0EZrCxAW
	 WLyD7Mg4cKslhjR7GkGO5ZVzDFJkjXz5FeDCrR37GKj+0vq5gozqwD6sm8A5JEy8VKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684397;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=iQGc1a0+VZ9GTDpXbNUPI4FqmxbVeu12fE6U8HXCQzo=;
	b=OKm5BYer3bcEGxPaUE9jNb+9+VBB/XbZnOGo3Cvadh0tjEb9l2VRuDEYapvmkood1P5c
	 6PV3W7nx8aP7w7G9XAPGzu19Nb4HcXX+V+1kruGKYT6q9z7saTlWHqkHtKVZk1IxTtZav
	 J1AztGi9agc4heY/jQZoVf9cNkpdszqvz/CX/TnXZk0gvCJTTb7/qqW0AWdhOVb7tI6l5
	 O6Bc9AXFxzP8p+/Qvoh+YA9xSW1ASKqG7hFHKrzE0zrdgUv/Y7LRxkAZoxKmsV2yfvVCG
	 L/E1F/mh6g/YzlK6PmTb/JDymPFRoMJnWR0CAsfhQ8GxGO7bZQx8YFalkScVUg6pK9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JCLoEJj5;
	arc=none smtp.remote-ip=95.215.58.216
Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AF606A31C
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 09:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JCLoEJj5
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=z3IPMrDchrEr+rWsXU/F3Ni8IAcBIA2oFTs4vzXuIkU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795684394; v=1; x=1796289194;
 b=JCLoEJj5dsEHBby3T9anusjNrNjLlZctuz9ZfP8m/EyWuiL3onHDdLeaRB1/NAPQDg4h7eRL
 fYvUCKUCmyc1Gr6rfTw52SxzQKOX0QJZFEKY+KDd81BMnZVXmJe9pqZ1kLKJPdIEBlLedjcZFFl
 IPXd3PV5bDvsKhB0ps6JcS4k=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c8a80f542e4f1fb7;
	Thu, 26 Nov 2026 09:13:14 +0000
X-Mizu-Trace-ID: c8a80f542e4f1fb7
X-Migadu-Flow: FLOW_OUT
Message-ID: <5e8c59f4-eb60-4b3f-a267-a87ef11ce6ca@linux.dev>
Date: Thu, 26 Nov 2026 17:13:11 +0800
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
Subject: Re: [PATCH v2 06/27] mm/damon/sysfs: add producers/nr_producers file
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-7-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-7-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Implement a new sysfs file, nr_producers, under the producers/
> directory.  The file will be used for generating directories for each
> report producer, in a manner that is similar to the nr_kdamonds file.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
