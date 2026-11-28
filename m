Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876032;
	b=sku7DlDjAY3KQjsDz2O4uMVLWnMNuh9rYRqYTvePzAd0M5N8fD2ELb8/L0XJz8aGk0ZH
	 kl0z/Q+M9+6av+OaFp5diC2uL+H2o1sTJ0eVxxjtzjtARPQ3+tepkCDu8EuvKsfLS+ykT
	 GRqr0WZ0OooicgI61U7xm+M7JBYEEpeVFR3LShcw2RXHVDyLjsgG3aknyCFu0tzoxNmtr
	 EYTeK6kgATZeyh9ijTUaIlqOmwems0hZUKS2mf6/dQ33iLonn3iJrlfwAMPS5SKg4BpEc
	 8eUVZEghaNwz4lkm8oa6gAa+FylpdmCuGdU17pOIGl3Zwj/V7VoagC0yOov+AIrMRQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876032;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6YxoHD8EjvwNzsR5djM/Ziwv7IE/NIkQh5YxPmJQqnM=;
	b=TEescb/N33waKAJ3J4dGbAwMrhYVJ4NAIXN5gVQjMUnMInIiDediF5cF5d+WFE2MjYGh
	 0NysIjKSNJypAbMA5AGLfKj5GD960KlLiFulM40cWnN2D6vaAtlkFvsQE0Sr72ffgtf7o
	 bGDbUOAf9sPSRax4MnV/F1uclbuU6BNQWiAEWwXfh/WfvK8xbXiGOC1lvsbdU0nLqw3Pf
	 27+5rhr85IDy/etLKwcrxmATpcIUPEeBoqa2S2BTsMgXhMKBUyzMjxdYUrqDBkVHbsTA5
	 HschEukODCroZjjNk3IvKA/EC/SxJKiVFofar2ClW1nLCSzDyoJPJe4Rk1Lu4JhhBKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PtSw2TDC;
	arc=none smtp.remote-ip=95.215.58.140
Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DE606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 14:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PtSw2TDC
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=4iVLmZMWa4TmUPMVJYNzqUOoeGWgk4BWGeE5J2RaRK0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795876029; v=1; x=1796480829;
 b=PtSw2TDC7PjphsML8CmyNK5FbC7DXbBMvSzykBPvD5Fq9THosx1DGN2/EH0Gb3GMp1EoQeHs
 HdHtK3eR0WZTmKYDKcTwCE8jF6H6NJQeyQ5GiCJxesIvjIub3JIMp30HtgXCzxE1X5Lr1T8FoM7
 os2rZijOpwMzF7/r6wzjDojc=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 7e42a4fff7619fbe;
	Sat, 28 Nov 2026 14:27:09 +0000
X-Mizu-Trace-ID: 7e42a4fff7619fbe
X-Migadu-Flow: FLOW_OUT
Message-ID: <8b85137b-d3c5-46f1-b232-a4df47f086c1@linux.dev>
Date: Sat, 28 Nov 2026 22:27:00 +0800
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
Subject: Re: [PATCH v2 16/27] mm/damon/sysfs: support REPORT_MADE type probe
 filter setup
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-17-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-17-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Accept user keyword "report_made" to probe filter type file.  Set the
> damon_filter->type as REPORT_MADE for the input.  Setup
> damon_filter->report_type with the filter_report_type user input.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
