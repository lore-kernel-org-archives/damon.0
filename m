Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C443BDA4;
	Mon,  5 Oct 2026 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192268; cv=none; b=dmvO0KSrBzcrbmyyINt1fVTGUoqTMYIh5JDze0vYL6IolI5hKXiFrgTnPkJrbMR9LVeTHtmQKGcbN0nd+6TBbUY3bcLC7l1rz4AG5sNH6rsEHVjJcXzg/EcqtBfBFLO86zY3tv3F+q5urrCC39dK3TTnF8jxZrnavZjtUjqDWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192268; c=relaxed/simple;
	bh=bxJy8VnPmQ9UEO84OpEog7+y8bPGLl9Qri9hoyXXfOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pM/qXPzqzZEqUIBjK9xwnmvoX+9en5HZqYpIADO+xJA3aQf8D+EXw8CUVaQisVycHk6O9ENnhgNNE6v4vuglhwG/4p0WO/KSJ+wqYHR5sDTiWtnhAXXqydPC6DUJH2NXD3mJqjxGu2pAhBkBAStGLa9lyMNLrGZs5ybT4hmOv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCjJkLZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCjJkLZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226981F00893;
	Mon,  5 Oct 2026 09:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791192266;
	bh=FLr/rCkV16XHpH0zaj+dpRly0K1ghzdKwwNgfOS+UnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YCjJkLZ9MXn7y0Lsm6P7HPnE6jkkE1f5lXCdIUzYOTPUQembvevd8akIlTMGiapSY
	 2FSjrunI6Oj8qT3+mehFInIrczhaWPZKFILKNCudyCsQm1wPaWK0r+7J5XNq/DnAyO
	 ZRoRM/iLOPoEb5KqFtSB92igYaCbhTjXFuIWJlz23oFMBIcL9rsGBAdgPAEvh01b5h
	 CT623cf+o9U2Uq9txVEymaV3BZQx5UhnCr8v64+PGzMyMqWJhVew/AYRrjyFbuh1uM
	 jBw9y/+ktLV03Zsnzi83HB9uQ9x5j/6K4D0Ugna5fswmKmxPKZVXcYPQhkOYNwXlXA
	 gx7VoC3XrVQTg==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	David Rientjes <rientjes@google.com>,
	Wei Xu <weixugc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC PATCH v4 0/9] mm/damon: hardware-sampled access reports
Date: Mon,  5 Oct 2026 02:24:20 -0700
Message-ID: <20261005092420.43681-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ravi,

On Mon, 05 Oct 2026 01:46:44 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> This series lets DAMON monitor a hardware-sampled data attribute -- the
> addresses a PMU saw accessed -- through the data attributes monitoring
> (probe) interface, and run DAMOS schemes on it in data attributes-only
> mode.  Patches 3, 5, and 6 are co-developed with Akinobu Mita, building
> on his earlier perf-event proposal [3].

Thank you for this series!  I'm in travel, so it would take time to review this
in depth, though.  Hopefully I will get get some bandwidth starting from next
week.  Feel free to send new versions meanwhile, if you think those are needed.
I will review the latest version when I get the bandwidth.


Thanks,
SJ

[...]
