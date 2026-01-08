Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16087245020
	for <damon@lists.linux.dev>; Thu,  8 Jan 2026 05:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849178; cv=none; b=VwHir1G7qW8L46CiZU3X3q2KpUanmb5On/LY3dy7XQc/F/uhpWRNlbnBhez4dD80J7GkxlOizTXplQUYBz3JvExaIHNM7FYysaUazsZRrWNgzHQHu9UUs8a0OegLPcXAEsDtasdq+6OQT4LZrkHzjx+Kaxo1ayi0GZE0Hr6qyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849178; c=relaxed/simple;
	bh=QIfzWMb0DNiwWefcZq/2yQSEyvgUvaKgQCA4R4LPX+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsenLSpDxSV1hx4gHVWBHBIHaUTkilqYcrsJbYZ7qyQdowGkcbkGZ+Qeumce8kS8/dAx84WvF7dNhJX14kfjmtoLNKiVZ4eqlvdLIfJTxNv71KXZdOz1qybwNfzaAb8oZ4TSaKo4Mn/KStk5wW91312UPxM4uOMaS0fQJinhaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3zoCxQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3zoCxQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71021C116C6;
	Thu,  8 Jan 2026 05:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767849177;
	bh=QIfzWMb0DNiwWefcZq/2yQSEyvgUvaKgQCA4R4LPX+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3zoCxQgz5NnUbZID3Qde47T33yvva0nq6nQ0BVHj+rrwo6p0uJPRxn+hYHHeHlWe
	 n/MfUseHhPQQtNPwAOJ/oZLzk/ZmSyZLuI4QAVvG+hh9qNtXEtHkDAujxrsORBwe2F
	 oAYOibT3b7gB5+oYZ+Yfgm/4X+u10bYTLW2hANudcTkcc2yJcCbHeCU1CjqbLvq2xl
	 5WZXdLvAjs12vIkS+Z3YUVFhyD1zFVebuBYyocWUuEyWJVw9g24jmaBbWlalh7OGCX
	 A+1sUW9oqh+Iso4dOYLYEmJEcLgqeKds3CMXTA5l34XKBqvYgbuAP+XIjCYJa6g0TG
	 5LLX/zVpCDNxw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	klourencodev@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kevin <kevin@desktop-mu90jgd.home>
Subject: Re: [PATCH] mm/damon: fix typos in comments
Date: Wed,  7 Jan 2026 21:12:49 -0800
Message-ID: <20260108051250.81675-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217222609.3355-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

On Wed, 17 Dec 2025 14:26:09 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 17 Dec 2025 19:12:16 +0100 klourencodev@gmail.com wrote:
> 
> > From: kevin <kevin@desktop-mu90jgd.home>
> 
> I think this should match with 'Signed-off-by:' tag below?
> 
> > 
> > Correct minor spelling mistakes in several files under mm/damon.
> > No functional changes.
> 
> Thank you for catching this!
> 
> > 
> > Signed-off-by: Kevin Lourenco <klourencodev@gmail.com>
> 
> Other than the inconsistency between the author and the Signed-off-by,

I saw you addeed this patch to mm tree after fixing the above commented
inconsistency, as commit e8dd7a6b54a8 ("mm/damon: fix typos in comments").
Thank you!

> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

But I just found you didn't add the above Reviewed-by: tag from mine, to the
patch.  Sorry for catching this late, but could you please add it to the patch?


Thanks,
SJ

[...]
