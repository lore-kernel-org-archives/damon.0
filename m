Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3D4A8FD1;
	Fri, 16 Oct 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163298; cv=none; b=Usql3l1zbTsD5qGaJ/U8lFAJZa22EbYkkdIHeldN5OfrP8u4WEkxb7pLaoJkftoPae0nt9nSKFZFMnbJYaBZK6Rmmv+lM+c4TvLQKWVGHogn3nxwuYbgtJbaDl83AEaLZoeaS7qyfo5r7R6oOwSPZQk6yC7rR0n0jLN/bmlWrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163298; c=relaxed/simple;
	bh=f5nklyBFzeuSBEmK+uzl03MFDh3bWmGJVnhn9hpoSPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkAVBy5A7rlg9KdNck0X5o48F34salkZS7skGQKVvptqBTA4ONWISSOHj5euRH9/BI0cYdKSIHqxTOpMHVNjrHoX9jsYYz2HvxFo0gNX9c2I179hscCALDqSHFG9DcE18WEp6xQI58kji0UVuGpElf19+dGWFjby8sqSj/OnOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwMOGeKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwMOGeKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA7E1F000C4;
	Fri, 16 Oct 2026 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792163296;
	bh=9GaGFNgl1GBFYDagkb0NG6gNUC4bplBfbJ7IM8ysGNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwMOGeKBmDDimGvJ6avqsU4zzJU6oWHAMnplPaUKcB5a+3D2eBDGJJHM7kcMRy0jH
	 YStCKJccgkyStEtEmklxkcSls2oWI1cH8MRk3TBwKxeuZdAfztE6/G0kfQQvJY/w6n
	 OOWz7ELc2KTC+Joy4OR3JHx0KEWw2Ox63TAH+TflmLFmOe7u46nzphV4K+jArOS7PR
	 KY82tGQhzfpp0o4wZgNT12wN64DSZY6iH9uP4x8Bp7qcYhTcbLzmeJseGuGDkeI/MW
	 oDPO77sWv/FyP3H/eTO+1EQwQSSHj2vJ/DOb7WfCe+xr+/7ZHmPZclFCaHVQqwZjgm
	 VxZKJRhu4KoMw==
From: SJ Park <sj@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com
Subject: Re: [PATCH 1/1] mm/damon/core: Remove unnecessary zero-initialization in damon_new_ctx()
Date: Fri, 16 Oct 2026 08:08:09 -0700
Message-ID: <20261016150809.92159-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016143733.320-1-adrianhuang0701@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Adrian,


Let's use lowercase for the first word of the subject (s/Remove/remove/), as
that's the convention in mm.

On Fri, 16 Oct 2026 22:37:33 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> damon_new_ctx() allocates the context structure using kzalloc(),
> which already initializes all fields to zero.
> 
> The explicit initialization of passed_sample_intervals,
> next_aggregation_sis, and next_ops_update_sis is therefore redundant.
> In addition, they are later initialized by kdamond_init_ctx() before use.
> 
> Remove the unnecessary assignments to simplify the code.

Makes sense, thank you for this patch.

> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree after adjusting the subject as I
abovely mentioned.  Let me know if you dislike the change.  We are now quite
close to next merge window.  It may better to focus on making mm.git more
stabilized and therefore ready for the next merge window, rather than adding
more changes that are not really urgent.  I understand this series is not
really urgent.  Hence, Andrew might not add this patch until next -rc1 release.
In the case, I will request adding this to mm.git after next -rc1 release.  So,
no action from your side is needed for now.  Let me know if you think this is
really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
