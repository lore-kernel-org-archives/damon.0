Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78017225775;
	Sun, 29 Mar 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801812; cv=none; b=WXgXsSB1ZFlQsDsZNX3jWebsdaAmL/WkpuV7LL0L/5Z882i/W8X6cj3jGqEYZ2G5QtPG54j17f4AHkABFhzInxOMvGx+7S9Hil9SY+5F/bc69NjGGWZ9LdcBz6YkeolBQmUnTZP4B9V/0QZETADfo1SRBgIrPhl/H5V5QhNUVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801812; c=relaxed/simple;
	bh=wTrqNZ6KAvxHuMYghGXn848rhimlN+yguVlRQ1ZjdNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTJKEE6CXYs+eRBUmWEzLl/Q+5G7NHu35mrVfC62TdpDgQg9egbPWnlaQmFaqr5pk3z/qoJF3WJm8io2d2PMheHSLlmoQakjLfYSBjEp3vH9x9BOdXFD9g5Z/6/b9oi5ak7CToewhKQbjcAWSNVUZC5IMEY3+u8FAd3xHAxomro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX20iqBR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX20iqBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED064C116C6;
	Sun, 29 Mar 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774801812;
	bh=wTrqNZ6KAvxHuMYghGXn848rhimlN+yguVlRQ1ZjdNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WX20iqBR4LEVwbeKZmMhA9DQnisxAZuZrnqZXuwPh7EThxc4TjpnBrFFYgN/3khzc
	 wz+m3Px3nm3JFY4PYXoxfMNOquBUfSTFOlhxDj6KCm2dQppGRHlv4JNzCrrAnJooLu
	 c2kC3OdPYsRercj9mHHW4mSJMobvV2/S1lI0EhIN4g+eay8Y1uF/qjegLJntFk0vuM
	 E7j62n1i+PU4sCt/A0DXo4wW4uaYEjUE5W+jMPsShPZKfL7VseM2GFQoiWAOoFuUta
	 lzqVEGnpVBx2aXx3Dy0rkrbCoxiRlFZ95FcfvVaHdQZ+x0fsxgN8BM7wKd+6YAZp1y
	 aOsjUjgmtPPKA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Sun, 29 Mar 2026 09:30:10 -0700
Message-ID: <20260329163010.58573-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153346.46881-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Mar 2026 08:33:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding sashiko.dev review status for this thread.
> 
> # review url: https://sashiko.dev/#/patchset/20260329043902.46163-1-sj@kernel.org
> 
> - [PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
>   - status: Reviewed
>   - review: ISSUES MAY FOUND
> - [PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
>   - status: Reviewed
>   - review: ISSUES MAY FOUND

TL; DR: sashiko shared good findings, but not directly related to this patch
series.  I will separately work on those.


Thanks,
SJ

[...]
