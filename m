Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC643CEF6;
	Tue, 30 Jun 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831050; cv=none; b=UZ88Dhj3AYXFKWnpb2iGSvxe0lU2RAgDK5kWpk0+ZfqEJWTB46C7HfUj/BC4Q3bPJ7jNot/vy6B2JTi+3tj3VKtbKsPBslSVrkF9VCfiHIScFhjRHcFDF4KFUaCASfENf5NsVBo3oBxBlwxY5VvxTYATF1gRXHXcIvBsD6LMGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831050; c=relaxed/simple;
	bh=9qmqEJnVisVPi630zDwKAJknSxh3Tq7I0o/MhRZMw6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPiRQVx/ZJcSP+87FRJrdvrJt4eK2wJ8Q75CyNSaxw5lOCDSPTBY9uV4Wtuab9Ae6eEeyGlSShvQ4wjL9AhUIjCU0b5Io5a/NV4XA2bCz530IX6Wlj3kohXzM5QxNDkOGDuFBhFpZsyJr2cvlVePAioUnFhkYAdM8aiieNpSf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWL4hHLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWL4hHLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AC31F000E9;
	Tue, 30 Jun 2026 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831046;
	bh=JN7uBRPSVFgxr8lo91sF9pDzgRuTFCqZj5C/tFQXtwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jWL4hHLBIgba6EJXfqBc82Vac+QTKWtgXVYmDn4/CYzwGjgF8051LfbfjGuWR+53M
	 oHc2lPTCvbPPS70LBwkNnEmeX4YNzgq7bs0r22YzFBUuJJhGZMLPXqe17YPdmvwUQn
	 gsRZmBovl5Dl7nHdXWwn4RHTJdVdYilXOGNW+2jFd5GT4qIQtfQF6N2qqPg86gqEMg
	 7tXop52CpsR70fffKJIcnu3BNt/RPZYZd6H5AauDkm1rAl3Rj3h20c/tuZa3rrA8qh
	 4F6a9qPeGa7YL1gBsu7ryBcng7jIzXP49YtG2oiNBro5F0URGeKEMvJDMebvykN0tu
	 xGmJYpReCweQQ==
From: SJ Park <sj@kernel.org>
To: Igor Putko <igorpetindev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Tue, 30 Jun 2026 07:50:39 -0700
Message-ID: <20260630145039.92859-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630102400.reply-damon@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 17:25:22 +0300 Igor Putko <igorpetindev@gmail.com> wrote:

> Hi SJ,
> 
> Thanks for the reply and the pointers!

Thank you for quick reply.  Nonetheless, from the next time, please reply to a
mail you are replying to, without top-posting [1].  Also, please wrap long
lines for reasonable length of columns (say, 80 columns?)

> Regarding the issue Sashiko AI flagged - I dug into damon/vaddr.c, and I think it's a real bug, but it's isolated to __damon_va_three_regions().
> damon_va_walk_page_range() is fine here, since lock_vma_under_rcu() handles stability on its own. __damon_va_three_regions() is the problematic one: right after mmap_read_lock(mm) is taken in the caller, it sets up a VMA_ITERATOR and runs for_each_vma(). But mmap_read_lock doesn't stop the OOM reaper from running concurrently, setting MMF_UNSTABLE, and leaving empty markers in the maple tree. Walking the tree in that state without a check_stable_address_space(mm) call could lead to a NULL pointer dereference.

Thank you for detailed explanation.

> Since this looks like a separate issue, I'll prepare a dedicated fix and send it as its own patch thread, so it doesn't hold up the current cleanup. Let me know if that approach works for you.

Makes sense!

[1] https://subspace.kernel.org/etiquette.html


Thanks,
SJ

[...]
