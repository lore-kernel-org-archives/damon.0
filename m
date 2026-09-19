Received: from mta1.migadu.com (out-169.mta1.migadu.com [95.215.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC819B5A3
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821563; cv=none; b=XpxiJHAbys8bRS98DQiCePdJ1NdGMhcJh0cBp+/dJxKiyw0c44uErERe4KnmYHg8YQ0r3KGlItqRWNSp0sGNyb/AdM0m7ggi3crdzZUY/ghQs0smyFzMyL9AUmDLjdMBgWCdAee41GgO6hkTskMb/0Eqm6qV6J4q0AyA7N4ZDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821563; c=relaxed/simple;
	bh=63TAU/20trh3z6ZWmLlRWwzB6HR6yfQpshRqu4iyzzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxXUeyK60nYPpC3JZKITC9gkqJNcwOwLlYSaDJNZNRH3p1JdrKgy6lGJWlIWrKG74ilMsc8F8VZnYdyvVZnEewUB0P3SGQnIYZnxZY37dLZmd5AJ/GzIKY3fN0LWR/G8WxP/UmbYZxtKnZ4dHbEVVbS+24Tix9mdj11FmrjihSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PB5lQdny; arc=none smtp.client-ip=95.215.58.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PB5lQdny"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=63TAU/20trh3z6ZWmLlRWwzB6HR6yfQpshRqu4iyzzs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789821558; v=1; x=1790426358;
 b=PB5lQdnydCZ+8HxpMA6fr1TxMOUTZ0dGEfTVtjzKq4p9Qfl6Z28VZLewJJODMtjSgOriE43z
 s60beLBYJu6Y17MAv9kUicQOXxXT3RH07Ad32d2awo8Di3FM31PN8bERGm/yg/cTkM7AbGyqczX
 q7q4yxBWVj2Gvi+BMi29Wn40=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 39ea79bec7641d4d;
	Sat, 19 Sep 2026 12:39:18 +0000
X-Mizu-Trace-ID: 39ea79bec7641d4d
X-Migadu-Flow: FLOW_OUT
Message-ID: <f38bce8f-ee47-40aa-a215-e2e605d17c91@linux.dev>
Date: Sat, 19 Sep 2026 20:39:07 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] Docs/mm/damon/design: clarify bp is basis point
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-11-sj@kernel.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260917142210.90829-11-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 10:22 PM, SJ Park wrote:
> DAMON design document uses "bp" for "basis point" in multiple places.
> Because it is not clearly mentioned, it is difficult to understand what
> "bp" stands for.  Add the clarification.

Exactly ;-)  I had such confusion when I was reading the doc.

> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infradead.org
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Acked-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Thanks,
Zenghui
