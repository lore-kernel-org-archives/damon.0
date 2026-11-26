Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677983;
	b=xSQGy4vc+X15ilWtc5zLrui+/OUM36tpfxzhNozd3oDhQm94213YeZapE7uGwuIcHwwL
	 Q6BRttGjvnJJ5jQireGRVZrqfNgbELs1l549hqt85hzhuQfDTuWnIfu4D8rE1a2elizLk
	 dhwanPLpCVyXTRh1QEm3eEVrQyVbcaz9bz4SF0F5P1CJt+KlUJW/qwnB1YfLemb/vkMMU
	 EJXF4RZsb4HAtABLtiz9j0X22Wylo+DIccFs2Vm+cGDtHIudG9DI7PlZHERZHVfkBHSXy
	 p5mL7PFMtv0zZKsuWtyuRYaAHk0wiYpG17UDnf/rxD8mgG36CF7duqsHSZqt6W1jgnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677983;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=xXhMDzXROUrP6zH1iZr5JFVo7mUfWfuBS1RHTgeL3j8=;
	b=uVfpv1MVK2DjB1PC51bBqYeVpS1jR194rBWtHPjuoiWih/egUnNOzNyDvsgPyucFP73f
	 sIF4/tadwE+nIAhugjRlzLvK7Odg2M5TqZ8abd31r8qe8IYKSYzBEFv+Yu+T9QWb0ZGTU
	 Z6AHhg3Nqi2s1o1+RPiW2brAC2ACYlFoPu9PUvD5y++gYVttcV/vmR8EQ9mzn4Tt7tPPK
	 y5DTaZAfUnPwbZ6HiAKzl8oTN9/ngZZNiMKcid475Kb6tgChYOECduTW7Htjsa5x1Dgb2
	 sTG7lue5ASSchlK961v5b2CvSU43Xv1rZoQgUfenTy/a2wah+5RT1WwyG6jOMX6kIjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qTBHxcXN;
	arc=none smtp.remote-ip=95.215.58.228
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9D606A31C
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 07:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qTBHxcXN
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=gTa+FiRs62WDz953uXBqnXtabhJGkFZlwN7q3IrHJlo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795677979; v=1; x=1796282779;
 b=qTBHxcXNo9wpdFVX4/9vyn5CsJkqvoP2n2NrDcR9wU/4c72xEeDFykQo42MC4jSgpUujmqSG
 /VYXdCHRp/W772hYUdeePXahXtmlEkS5cslQLM908tDWjK/6LiXRs7xWrb7Cf6VFG+EFHKqPTaG
 bTme7vtbfDYW3oF0eL7Vj15A=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id df473b4b10cf1edd;
	Thu, 26 Nov 2026 07:26:19 +0000
X-Mizu-Trace-ID: df473b4b10cf1edd
X-Migadu-Flow: FLOW_OUT
Message-ID: <dd0a62f4-b6e2-409a-8863-7e2903179e3b@linux.dev>
Date: Thu, 26 Nov 2026 15:26:15 +0800
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
Subject: Re: [PATCH v2 04/27] mm/damon/sysfs: add admin/reports/ directory
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-5-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-5-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Add a new sysfs directory, reports/, as a place holder for sysfs files
> that will be used for controlling the data attribute report system.  Put
> the directory under the admin/ directory, next to kdamonds/ directory.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
