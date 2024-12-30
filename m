Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4801ACECE
	for <damon@lists.linux.dev>; Mon, 30 Dec 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583299; cv=none; b=DesO5Rw6v7KhmUXxSNTgmj/XXeKy76UnF3799F374L1vVkpZ7VHiVDJ0jGCFinmQwL38Wq+EvjjsWwASr+OPMOCuybqOwmekrEEscQVb7ZiwfGG6lI8nGLlkRWuhXFvz4jbQ1d01XntBhnJhe3VVxP7pniA3NuQ2UYPCxDZxyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583299; c=relaxed/simple;
	bh=U2YpTtqlCJIY1bpxAmY0gX8HWkNJ4GZ9RZ6Wnr2pBBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWqhMrup3jynZ8p8h4g4dneq+VAyegrDOYO9INm5f3/Gl0uy34T+EVFltREfp2jCdt3PRolyhV1EM86wfujgMwWruMZB+H61xKyEeK+YuUnGZHwGHla8TqLEaQREsAXWyl1NA4NZ2zg7hVzkJo9b2gEPblYrk+QttEel1gZY7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e34qp0hX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e34qp0hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0D5C4CED0;
	Mon, 30 Dec 2024 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583297;
	bh=U2YpTtqlCJIY1bpxAmY0gX8HWkNJ4GZ9RZ6Wnr2pBBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e34qp0hX5lnvN/wVs+id/n6r9AiG2VCg45VWhm1BcpdQd/vLIxiY1Mv3uzrSuGkmw
	 8fvpclyNSbvfoVwqnIPRtj+KJWp1VMCDBP9jpouSqaKqXd+bVj+gbArNNndU2LJc5c
	 GNm0dhmDfKCUQcCZz8dhkOVHss+WijkVdeK6d7Uk1PQr/GZweh72KDOH9l4SLTNgil
	 0YNX0bUTN/nlJPeCbKuAE6nR45N2tnVCZgvfRrP3zCJq36TafhaRGJFP/Cj7TrwrCQ
	 jAcUvyOU/C+1wnhw3f9qUuGRFT70rLTPZkX1cM8OJqZA7CjrRcjjLDuW+eQSoKna0s
	 EpI+y4qUwdQxA==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: trace: print address range in hex
Date: Mon, 30 Dec 2024 10:28:13 -0800
Message-Id: <20241230182813.14349-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241230134221.166041-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Akinobu,

On Mon, 30 Dec 2024 22:42:20 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Currently, the address ranges are displayed in decimal format in
> tracepoints for DAMON, but hexadecimal format is easier to compare with
> address ranges in /proc/<pid>/numa_maps.

I agree that it could be easier for the use case.  But, I think writing and
using a script converting formats for DAMON tracepoint output or numa_maps
could also be a way to resolve the issue.  Do you have any problem at using
such solution?

> 
> Existing tools such as damo need to be able to handle changing the format
> of address ranges,

Thank you for taking care of damo, too!

> so display address ranges in hexadecimal with a "0x"
> prefix.

This is a user-visible behavioral change.  I understand it is an improvement
for your use case, but could be a degradation for some use cases.  Also the
change could confuse or break old use cases.  I understand that 'damo' users
will not get such problems thanks to your work, but not every DAMON users use
'damo'.

So I'd like to add this change only if there is some critical issue or benefit
that we cannot fix or achieve without this change.  As of now, I don't see such
things since I think you could use some user-space tools for your use case.
Please let me know if there is something that I'm missing.


Thanks,
SJ

> 
> Cc: SeongJae Park <sj@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  include/trace/events/damon.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index da4bd9fd1162..8df59ef18660 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -41,7 +41,7 @@ TRACE_EVENT_CONDITION(damos_before_apply,
>  		__entry->nr_regions = nr_regions;
>  	),
>  
> -	TP_printk("ctx_idx=%u scheme_idx=%u target_idx=%lu nr_regions=%u %lu-%lu: %u %u",
> +	TP_printk("ctx_idx=%u scheme_idx=%u target_idx=%lu nr_regions=%u 0x%lx-0x%lx: %u %u",
>  			__entry->context_idx, __entry->scheme_idx,
>  			__entry->target_idx, __entry->nr_regions,
>  			__entry->start, __entry->end,
> @@ -73,7 +73,7 @@ TRACE_EVENT(damon_aggregated,
>  		__entry->age = r->age;
>  	),
>  
> -	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
> +	TP_printk("target_id=%lu nr_regions=%u 0x%lx-0x%lx: %u %u",
>  			__entry->target_id, __entry->nr_regions,
>  			__entry->start, __entry->end,
>  			__entry->nr_accesses, __entry->age)
> -- 
> 2.34.1
