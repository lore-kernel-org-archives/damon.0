Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAB3CF68B;
	Mon, 16 Mar 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681941; cv=none; b=aJj5GsHJqKbTc46c5dgdNSvpdBiwNo0wC8PzRtPX16PMCTloBRPQhPtB1ZF3xFM/OSXrRx/UE2OAe+dyIqtypZGV0IEluWKpoXfJ8+KnxPkz1WjgyKClg0K71ecife5BHhOemX2W2yV2b2YHBRqoQMqEaW+sc2+KgGKEfVBfTME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681941; c=relaxed/simple;
	bh=/OYUQzvbizA/HnFcDSxx3chz1+uWDAT16QLEnDDvjhY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BJRXFu7xwGOJTjx0G+uXyJdxzCVeFYA2A2FhszWLp5FrsDTDkEBszN8kPX5gbMAdXZ2wtStr+oxG+dEnugJ0JuDxoaDlIkDg3PJNT32eqJQRe9PEwGtsc6eXuD6BeXtjuRGhHFDE0qk+Y895m+Jv2xqzuMYy7VwzslVsyITj++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Umj/WqyW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Umj/WqyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F6CC19421;
	Mon, 16 Mar 2026 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773681940;
	bh=/OYUQzvbizA/HnFcDSxx3chz1+uWDAT16QLEnDDvjhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Umj/WqyW7820d/fMeiEsgdsRbY/VadfKZl6+bgrA1xdbsU8fNY4yW0TxP7k99k2mG
	 7G5ZIrfMbx2ThX2VzYgqG7sKNqqK/9Pzq8ygwaRpP3jxJ4Mdv9UnXSupmEQfE5y6W6
	 G8TWLdqhDFLeH2pd0tys3pcCxsxQh9cB+dgdhrAo=
Date: Mon, 16 Mar 2026 10:25:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 17 . x" <stable@vger.kernel.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon/stat: monitor all System RAM resources
Message-Id: <20260316102539.2af039f5ca7ce1164da34b47@linux-foundation.org>
In-Reply-To: <20260315162717.80870-1-sj@kernel.org>
References: <20260315162717.80870-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 09:27:15 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
> says it monitors the system's entire physical memory.  But, it is
> monitoring only the biggest System RAM resource of the system.  When
> there are multiple System RAM resources, this results in monitoring only
> an unexpectedly small fraction of the physical memory.  For example,
> suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
> 500 GiB System RAM resources in order on the physical address space.
> DAMON_STAT will monitor only the first 500 GiB System RAM.  This
> situation is particularly common on NUMA systems.
> 
> Select a physical address range that covers all System RAM areas of the
> system, to fix this issue and make it work as documented.
> 
> Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
> Cc: <stable@vger.kernel.org> # 6.17.x

This doesn't apply to current mainline?

