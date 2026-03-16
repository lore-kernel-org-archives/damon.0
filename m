Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202839EF15;
	Mon, 16 Mar 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674041; cv=none; b=mWF/9RzwgA79J+g/TN8jSWIUe4J9FMPTbH0xmDXlfs8zbzqTZl+xQ0xtUSON+UnP4Cv1gXPEOydOCA7mIMa1Q2aO+VubMLDJbWNiNZrOMvkDm7rwcogXvWbC1+hBP9mF0/APM5/dYIJT35hDRUxl4s/Df4Hmos6I90643HkJ/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674041; c=relaxed/simple;
	bh=bB17RaP+sGJYjZOD4hRJTM0tiGwcoxMhkY2sJcw5ves=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5C0CIpfI7OitLrwqoi/VsQeNAureea4riQODbQbe8qgG72QZvQxPwAE3qrpK6M7lyXQxJHwLHBACW1BD5HyHosGu4pyD1wiuSBWecZdHo6rTmHLtLnjpmnlULYypA+xKlkKV0L+7u4SXV9E86T+0oipCwHWTLzsgmPMWLLcYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko3GXsts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko3GXsts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D488C19421;
	Mon, 16 Mar 2026 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674041;
	bh=bB17RaP+sGJYjZOD4hRJTM0tiGwcoxMhkY2sJcw5ves=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ko3GXstsM7IxbccEWEVNpJtIUBpqwxPArXm3YDYSnQC5oQ+CoOMRS6TLtPunJCGOL
	 kMjaKrnvz3LzF/qU1/7j9hXCoOrjU8WMFo5D4dpZPeDKz29YkicMxJ+23W9QBb222Z
	 opWK88iI0M1fc5YhIksujtt6TKMzk2viiuT2MgoBq6XUS72X4DTFnjrAOp5c66KhT5
	 +rJvaUrp5WZPB/Rd6rSqc+xKQDorBFUyreXDJc/86GviYeLj5jQdNlr+ixJ0UYjJB9
	 f8RXg3oH8xuCxFSagTkGm8j+to/KHa/zJfihhtUxLTELwpT8lGpoyGIUsr8pJ1PwN8
	 Y2cJxkNGqJlIg==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Docs/mm/damon: Document DAMON actions when TRANSPARENT_HUGEPAGE is off
Date: Mon, 16 Mar 2026 08:13:52 -0700
Message-ID: <20260316151353.100406-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <224a29a1-13cb-41aa-8736-aebe1023fb7d@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Mar 2026 17:56:55 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 3/16/2026 5:48 PM, SeongJae Park wrote:
> > Hello Asier,
> > 
> > 
> > Thank you for sending this patch. :)
> > 
> > On Mon, 16 Mar 2026 14:08:21 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> >>
> >> MADV_HUGEPAGE and MADV_NOHUGEPAGE are guarded and they
> >> are not available when compiling the kernel without TRANSPARENT_HUGEPAGE
> >> option. The DAMON behaviour is to silently fail[1] in when DAMOS_HUGEPAGE or
> > 
> > checkpatch.pl shows a warning for the above line:
> > 
> >     WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> >     #12:
> >     option. The DAMON behaviour is to silently fail[1] in when DAMOS_HUGEPAGE or
> 
> Yes, this is due to the link. I tried to keep this patch compact, without a
> cover letter. I will submit a new version without the link.

The above warning is not for the link.  After wrapping the line, however,
checkpatch does warn the link line like below.

    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
    #13:
    [1]: https://lore.kernel.org/damon/66131775-180b-4b9f-b7ce-61a3e077b6e6@huawei-partners.com/T/#m278d3c9bbedcceaf2efa51e3dc7b40a40654e51c

But, it should be ok to just ignore the warning for the link line.  So, please
wrap the line, but keep the link.


Thanks,
SJ

[...]
