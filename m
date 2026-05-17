Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E47346FB5;
	Sun, 17 May 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041794; cv=none; b=SmAwL6vpsmi7n6t2O5F7TtCpOZHVjX0eVY5N8ruxfSKZUYV1tzIv4kUg5Zmrv4hp9OXxOsLM4weCOAEvb8410NAYrWQmy1ZuCnWJmd/Sil3TPbq5HnixvahIoItWqsNGfNLzy9ntjk8FloraCFVknpXdbGlJJkMaBEMM/gfYVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041794; c=relaxed/simple;
	bh=2LjQGuHt3gJmMSN1V5zTjOPDreXxMJTzVUenpE4AQek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+ZogBKs9fDRryhX1T0kx0YCNVrLmy4zlMsO4fsju70s4Yiz9oVunwtEJeK4VufEAZNjh7f3J2VBt4HQ1b9Gfx48Asc5+fb8gO7uhBt+LqhXgHdG7da+ddzNQLRgAOwZoxZtPl/d3UdXxZvNiNQn4sUgnv64hGIohsYlK6jZ96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llW5hoWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llW5hoWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D74C2BCB0;
	Sun, 17 May 2026 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041793;
	bh=2LjQGuHt3gJmMSN1V5zTjOPDreXxMJTzVUenpE4AQek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llW5hoWyA3xyVDIgX27lTy8NwbkEMuA3Qrv8t/2vYHuGeKeb7abfH3H3NvZOl7r/f
	 XCZvTs+0b+QY8lLv28kXx5Q08z0c8AomK7ues0nwgsuatcq6MKmAGHSqPHxIs+cE6z
	 fRHYbjspH3Xe2Gk0JojMaFO3o445zI31wQjMdSNNpwZ0CNsHl5wtDt14DbwrTDcTys
	 CMeIdNXCuUM0o0W2eqnlyJxKsIWC/hsBgoISeqYI1s/3srSV/OTISVnhACxkOr8a5K
	 R+UlR3osIjrKIOXyGSJF2nHRjS6cqXjKndeqMogL2ea5W/MaU6iBzxI/h/TOFujjUA
	 xfP+EfKEVcMQQ==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH 1/5] mm/damon/core: fix nr_accesses_bp underflow in damon_moving_sum
Date: Sun, 17 May 2026 11:16:25 -0700
Message-ID: <20260517181626.4104-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516210357.2247-2-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Ravi,

On Sat, 16 May 2026 14:03:53 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> Guard against unsigned integer underflow when nomvsum/len_window
> exceeds mvsum.

How could this happen?  mvsum is assumed to be same to nomvsum at the beginning
of the window.  Hence, even if there is only zero new_value, at the end of the
window, mvsum should be exactly zero.  Of course there could be a bug that
breaks the assumption.

> When that subtraction wraps, the moving sum returns a
> near-ULONG_MAX value and corrupts nr_accesses_bp.
> 
> If subtrahend > mvsum, return new_value: this clamps the moving-sum
> estimate to the current observation rather than wrapping.

I guess you saw this issue in real, and this change should fix the issue.  But
I think we should know why and how mvsum < nomvum / len_window can unexpectedly
happen, and fix that.

Could you share more details about when and how the situation happens?


Thanks,
SJ

[...]
