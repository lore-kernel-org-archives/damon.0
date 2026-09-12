Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB747D926;
	Sat, 12 Sep 2026 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244824; cv=none; b=FxFSaAFwbzI7H4ARRxEWX/A3+Bn2X+KJZH5im6CnEZqhw3DKx3e860LHiUY1qqOCmz8km/fTL0zaB1egtx+GTGe+/JQWAdUcuMdgw3xsj4pJAPzanaD7j99+Hi0FVB9odoou8Cy2OH0E/wEeHo3LN3yuXEXiJoqdPJKz3B5fqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244824; c=relaxed/simple;
	bh=kM3JJPiaXTndZvd7tj2ry3saF/uQ6t1zvE4gk9fSio0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/F57MZtgqLnajDrSdTxHRfGkj05TZfVLrXOnMKGYtTvMBFUOrzQiMCP3F+LABUWhjNVDwXJ/EkyfFsMjmNBT32R41aDhVN73TTWJMAk0cdgEBhltjqCcYH91Fb3H3XS5irHWpodYCzTbAGibU0GF5cjFghFqD/dX5Vj29SU/ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4SV0qYCZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4SV0qYCZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=k80GbC8BsCfGepmIx3SENEY1Kj4sK1tV084haoESIqI=; b=4SV0qYCZcJLmADDaWKZF+5HVbj
	0kZVZeWr9XaUFTKaFVYHtjcH/BSjFKVpuvpgu1wkUtkqsAH0jyH+n0BYomq8LtzasjuFsAt1LP19B
	repU/d3uHy7nVUuNKSjTGsIdeexv9vU2x7ik1Mz1QdyNMtEYR3d5ZzJpy835AGqAduJoSp1ApAHwN
	JnXZJ6dPji+wc8vekwJQwEkwD5UPYd6kEZsWCP0CD53E8kpoYT0T93Y20A8boKm194aQfYjvapoZD
	/V0/KHeywd8p/RTJsubKoRUbtKPemcsZsFfHjXhDJYhj/SrF/F02xU9D2ya12vX3hw65vuYyNMzJk
	CPrtX2/A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5UJD-00000001A29-1NQr;
	Sat, 12 Sep 2026 20:26:48 +0000
Message-ID: <d70237f4-462c-47f1-b550-5cfa91e08873@infradead.org>
Date: Sat, 12 Sep 2026 13:26:46 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] Docs/mm/damon/design: clarify bp is basis point
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-10-sj@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260912200814.145612-10-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/26 1:08 PM, SJ Park wrote:
> DAMON design document uses "bp" for "basis point" in multiple places.
> Because it is not clearly mentioned, it is difficult to understand what
> "bp" stands for.  Add the clarification.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infradead.org
> Signed-off-by: SJ Park <sj@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/mm/damon/design.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 0a86792f90a18..e82390e77a70a 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -445,7 +445,7 @@ users to set the aimed amount of access events to observe via DAMON within
>  given time interval.  The target can be specified by the user as a ratio of
>  DAMON-observed access events to the theoretical maximum amount of the events
>  (``access_bp``) that measured within a given number of aggregations
> -(``aggrs``).
> +(``aggrs``).  The ratio is in basis point (bp or 1/10,000).
>  
>  The DAMON-observed access events are calculated in byte granularity based on
>  DAMON :ref:`region assumption <damon_design_region_based_sampling>`.  For
> @@ -717,7 +717,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
>    in microseconds that measured from last quota reset to next quota reset.
>    DAMOS does the measurement on its own, so only ``target_value`` need to be
>    set by users at the initial time.  In other words, DAMOS does self-feedback.
> -- ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
> +- ``node_mem_used_bp``: Specific NUMA node's used memory ratio in basis point
> +  (bp or 1/10,000).
>  - ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
>  - ``node_memcg_used_bp``: Specific cgroup's node used memory ratio for a
>    specific NUMA node, in bp (1/10,000).

-- 
~Randy
