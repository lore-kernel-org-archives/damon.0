Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71B13AD38
	for <damon@lists.linux.dev>; Mon, 26 May 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748283154; cv=none; b=Kkbc7hsp7e/EWvjocVggadN5O4Rv02O46mRNT2t0icIkCEVP0vjjq5Bza5Ol3GHf2wCF6f90WsOgp7jcuWOv7EvhBechBb2BfkR7a11cy5Fni6j2XQyYkeR+gYzSjJzjFw/C/hn3JSR4e5JmKNp6CtTY6LZqSd95AhV69Nnl1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748283154; c=relaxed/simple;
	bh=pRB/zXLpYl5SoFUSrsZLkQQFMthcYXM5N/oSfBRNMjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXvbbRCEDBtwILASj71Qn9nf6Hj5K/mulR+lTSzNjwRhFqOh6BL/0Zy96TvDXcGzA6FyYjBZmJDbha7I8FHPtl14qojnbbjjB2GE+gyr0LO29ZDnogdJG4xIakGgOeo8813aWfdwHXaJTZvFUyjWlnc5MnLpuw6Uhh8QvX8znsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI0WG2C3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI0WG2C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398B3C4CEE7;
	Mon, 26 May 2025 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748283153;
	bh=pRB/zXLpYl5SoFUSrsZLkQQFMthcYXM5N/oSfBRNMjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XI0WG2C3LAdxl5mOLLw1IzPsLowxh9aGcf068VNP37ZWxkUbvYlEF3VZCYvaim3OB
	 GSw6epiY4/3VVJbZFL2qAdrLt4CiFHvl2GhT9kyYDivDbg03WZCrAWPxCmBq8CDz8v
	 hdMhx8wjJAdO5ktnBctSX9kQ35s9DN1wWQNl6ID0VZiDYMZqOsg6VV/+ufgVXdOzfr
	 BiZszxNLNATCpuFfSXV3SNMV6Rk28AzeRLNAEoc8iSVq51kb1XdKsjqYyutuEvMsFv
	 4QuLcV/2gRBtlNmUXajXcM4/Ck+G/3UV3EbS7IbVRC94AKaqEwIbfXJrY6Y2nH3yjC
	 wlKsjz9e1cfcw==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	enze.li@gmx.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: fix outdated comments for monitoring primitives
Date: Mon, 26 May 2025 11:12:31 -0700
Message-Id: <20250526181231.3021-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526060901.78226-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 May 2025 14:09:01 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The word 'primitive' is not explicit.  To make the code easier to be
> understood, this commit renames 'primitives' to 'code' in header
> comments of some source files.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

So we have an ongoing discussion for the title[1].  Other than that, all looks
good to me and I believe the discussion will not change this patch
significantly.  So, giving my Reviewed-by first.

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
