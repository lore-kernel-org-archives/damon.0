Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F1306498;
	Mon, 29 Jun 2026 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725157; cv=none; b=LZ6igTmSSCeBZuXhe9jIh8iB2esquJXWMOIdMVH9F2FrhDvhz1DJ/VRyqtTUbu6M5rQ9r5HTvmnsxN8TnzhkZqtfRfLk2TU10egrIrWZCMiI/sc+mNNwc+KtTsclV1SohUqzRBAQP1gQvd4B/qfbgMie8djSTW8Ngx6mWl8Ds/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725157; c=relaxed/simple;
	bh=gzaAu+Q+MXAEJVOPwqBJFR51dox9xmNAxwtRJcIczwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VESFeAQNGOG1xjKspDcE/wuhYz6AjeBQTui7yks7NO2CXlmi3dZ49UCdaRNLeltYQnU7jhP3hlLw9wYEandlrPzFr/xaRxd2lmUCmZmD9mdPW+QAT5zZmEZmIGjQZE5akThWX8Xyg0fW+TYrd0rcyLkZNIVdzsy7n/vJUpmk4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyZL9ojg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyZL9ojg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204A71F000E9;
	Mon, 29 Jun 2026 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782725156;
	bh=pdZf8FEQU/Nz7H0SIPDxFTAlCPeoMrqoIBM0aEQEZEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CyZL9ojg4JokMZn4tULoJ5z79GszhxB7MBh0TLLm6N8wwmKuIXzvkTEDqZDH4X90j
	 c8Ds+zmpG3rGJ2pGYIC3PRH0aWVsjOdpQCFayQQRz7w+KLNqB305ty1xb45Sc9l3Tf
	 cKiq8Y0MKEWjuv0hY02ct4Lt6Ht4r3zJnFEpQnSdPWLc/D+UEwDnalNlluo1+c3846
	 2gcKVeDGzzEiwej51RxTrzkTu1ZCIL385qHQqLCFrU70xVaQi9LcgiVmMRVYzXll0f
	 Hp8DEZ8ZwZ6VWzLJdMpWpmulsLykPi5bNUGXyNh2ccEygSlYvlA7OaaMelgd6NGkGc
	 4uADB6zoGjwQg==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: SJ Park <sj@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo Stoakes
 <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Vlastimil
 Babka <vbabka@kernel.org>,  damon@lists.linux.dev,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: s/SeongJae/SJ/
In-Reply-To: <e29d1211-8bc3-433a-b1d7-d7fb44c2f0cd@kernel.org> (David
	Hildenbrand's message of "Mon, 29 Jun 2026 08:30:23 +0200")
References: <20260627195630.24519-1-sj@kernel.org>
	<e29d1211-8bc3-433a-b1d7-d7fb44c2f0cd@kernel.org>
Date: Mon, 29 Jun 2026 11:25:52 +0200
Message-ID: <2vxzo6gtk89r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 29 2026, David Hildenbrand (Arm) wrote:

> On 6/27/26 21:56, SJ Park wrote:
>> My legal name and preferred first names are SeongJae and SJ,
>> respectively.  I was using the legal name for commits and tags, while
>> using the preferred name for conversations.  It sometimes confuses
>> people including myself.  Consistently use the preferred name.
>> 
>> Signed-off-by: SJ Park <sj@kernel.org>
>
> [...]
>
>>  #include <linux/pid.h>
>> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
>> index 1cfb8c176b873..fcf7c7fadb5fe 100644
>> --- a/mm/damon/tests/core-kunit.h
>> +++ b/mm/damon/tests/core-kunit.h
>> @@ -1,10 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>>  /*
>>   * Data Access Monitor Unit Tests
>> - *
>> - * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
>> - *
>> - * Author: SeongJae Park <sj@kernel.org>
>
> Just curious, why do you drop the author and copyright information? (can you
> even drop the Amazon copyright note?)

Off topic, but I am curious how these copyright notices are supposed to
work in the first place. From what I have seen, the person who creates
the file normally adds one for themselves/their employer. But then other
contributors who make small/medium changes don't add theirs, even though
they should hold the copyright for the code they added. Bigger refactors
sometimes add a notice but that isn't done consistently either.

So do these notices even hold any value? They certainly don't list all
the entities who hold the copyright to the code in the file. Only git
log can tell you that. Is there even any point in adding them?

[...]

-- 
Regards,
Pratyush Yadav
