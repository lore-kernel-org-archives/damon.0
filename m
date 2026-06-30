Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852B22097;
	Tue, 30 Jun 2026 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794948; cv=none; b=ZMDu8rKRG9+/oGYDs3fKIuOcXoVT8mx/A57JIsDy6tPzQraMM6tiPSASKhjD4fqQWsZC4OwVfi2/j4MYuzNyej1+IYu68LHgjAQjI8RW4BPd0z4J12TQic8krZTT4rdNAI6P1U9UMSq6jh+EcDG+2bPrI24O60L61+8aN55f9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794948; c=relaxed/simple;
	bh=LKMERi4bVQAW4ZJ0iQHAle6WqKB8DiyPG3y4kuc46qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzTOg92jylYx+dp/9RvkwCorS24tVI1TfYKzetts/rMlGYiBVit4dzwXZZfPnqbYxVxVfBaNG5yuxOTN7JUUTjnLkJv8Ks1tnPOTCK4H0CKXSC8KZC0+VMqCKa1mmKWFghwjXrKmGsT+xwvzdPxweu89QKu8UhMGMfPOsOwRg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXsALoPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXsALoPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBEE1F000E9;
	Tue, 30 Jun 2026 04:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782794947;
	bh=4Gu0EQk5gYr7y/NtUz4uOMOtRGCLqMMs+lpokWiBqd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OXsALoPPHIsa6NQcPP+tXlHn7YuGxrXgtyMWAySecQZLDwvTQCpU+Oc3EGhXvvMkm
	 h+U4MWcu9NaEgsQfrB3KSk0ImcwbuI+FPHE5Z+emmi3YDa5SfgXA0TIqSWjoqQV+91
	 19Pf3cAEzXXe+CXa3hHtA820a+SvArgioGRDZ7R7qxmT039MV9VYsgODpyZQv1R0TI
	 UjFeMlsSwxvPKEeSPb4+wjLzi3L9xUqo4n6xXeP6hDWa55STzaBbPRanhHfzuleM5H
	 WuuUimrJ6MTmsJK+CNrJ7dCKALsxYBgIYcytBsLrpxN9SzjEAIpdbmCXTKt+kvUOlT
	 3edw800F1KqFw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 14/18] mm/damon/core: remove attrs param from damon_update_region_access_rate()
Date: Mon, 29 Jun 2026 21:48:58 -0700
Message-ID: <20260630044859.152347-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-15-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 21:08:07 -0700 SJ Park <sj@kernel.org> wrote:

> damon_region_access_rate() is not using attrs parameter.  Remove it.

The function name on the commit message here is wrong.  It is
damon_update_region_access_rate(), as you can show from the diff below.
Andrew, could you please fix this up when you pick this patch?  Let me know if
you prefer sending a new revision.

> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 3 +--
>  mm/damon/core.c       | 4 +---
>  mm/damon/paddr.c      | 4 ++--
>  mm/damon/vaddr.c      | 6 +++---
>  4 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 87c1ff479da82..02ed47c558cc2 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1016,8 +1016,7 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
>  
>  int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  		unsigned int nr_ranges, unsigned long min_region_sz);
> -void damon_update_region_access_rate(struct damon_region *r, bool accessed,
> -		struct damon_attrs *attrs);
> +void damon_update_region_access_rate(struct damon_region *r, bool accessed);

Above diff shows the correct function name.


Thanks,
SJ

[...]
