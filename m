Received: from mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC842C518
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907705; cv=none; b=g2rFtsEJMVcdfDgmr7XYwEUNhSOXmZM/5X56SaqsssWVpBanDEAmuJW27A82ASEobh1CLtv7seGJ3OTj9XKZD6phpJ+nKXoAcaM3jP2KFBbMtq84Amr3V+4cSbuLc5bQHAUnWBA9DMKM/VFktlGHTtK6x2lG+NHfjJ+akK3wI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907705; c=relaxed/simple;
	bh=sdNk5ihNH2e62rxLPJrJeu8kriaPZjukMTNXWfJ6eB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMV0eoxEucoemecVKEb7r2/94UxMlnIo5aVuC4syFarBf9YygexFag7Eu8szUxwo5eWPOO5VUBFFNaIA20bPwQRARxMdgN7uAklj2iQTadAC+Sy/4QzemlOCqUTTAm8JQ0YQztjKvyzOQF4RfqJ7WZh6FO5tu93lCy+GMgDYF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XaAV6Fw5; arc=none smtp.client-ip=91.218.175.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XaAV6Fw5"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=sdNk5ihNH2e62rxLPJrJeu8kriaPZjukMTNXWfJ6eB8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789907693; v=1; x=1790512493;
 b=XaAV6Fw5xRx9xSLTC/tHHGWs5gPs+wRZbCC5dvevsE2mMbPibZQ0GAJkNOfUtBuwkKshuyDa
 G4qbt8+w1B4gNRE4uCDCNhSdInfWaa+c+OW/bSHvpFhpqLo5BeIHL7tm3FR2TEyQlzGbXTX56wv
 ko/MRAde9HZXgU9+jleslAEw=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id cbc0d603ec100e35;
	Sun, 20 Sep 2026 12:34:53 +0000
X-Mizu-Trace-ID: cbc0d603ec100e35
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0c63f91-4d33-469e-a584-f97fdf8c3cc5@linux.dev>
Date: Sun, 20 Sep 2026 20:34:48 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/api: remove unused NR_DAMOS_* enumerators
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
References: <20260920100029.46849-1-sj@kernel.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260920100029.46849-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/26 6:00 PM, SJ Park wrote:
> On Sun, 20 Sep 2026 09:20:28 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:
> 
> > From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
> >
> > NR_DAMOS_ACTIONS, NR_DAMOS_QUOTA_GOAL_METRICS, and NR_DAMOS_WMARK_METRICS
> 
> More than 72 columns.

I learnt from submitting-patches.rst that

  - The body of the explanation, line wrapped at 75 columns, which will
    be copied to the permanent changelog to describe this patch.

But I'm also fine with the 72 columns rule for damon patches (or for mm
patches?).

> > are not referenced by any code.  Remove them.
> >
> > They can be reintroduced if a real user comes up.
> >
> > Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> 
> Other than the above too trivial thing,
> 
> Reviewed-by: SJ Park <sj@kernel.org>

Thanks!

Zenghui
