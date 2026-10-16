Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019802D780C;
	Fri, 16 Oct 2026 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113990; cv=none; b=LUGNjIcTJuHBO3420rm0NootwIL3cVvJI0D2cX9/2MyS8EHC55CDUhVfW2I4pM5YArBF95Cezh/6NORGtXV3hwPz8ahNuDfydmmLuTUFjk8BG589ntLINj2RCllJT5vn/KXXY4UFSvfRcb+s8P7C1ZmfgEsSHKqH0acFmjlpT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113990; c=relaxed/simple;
	bh=tqwpMGzINRmAeZbAKYGaiBm15TKrFsD/xJ/32gvfLXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY5WyYi3idwGQQsvEQjlqEkSkBysFKdfTyCua5QyfR2lDTdm3o1mVSnHgZsUEX7OPcS9cvKcUW/mD15373IFUKxBg4N8RVgy34Dyy9Ms5c6cQkXcYGRHy6IBqvhnZYWCCpjnYilSNZIgLDPgqoeTIbRFJ7a3qL8daoC4cmwkguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN2TqF7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN2TqF7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B86F1F000C4;
	Fri, 16 Oct 2026 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792113989;
	bh=3bd81Hi/rmFImpkTrd3Z6omZvXbyOiJ0Rex3nfosaXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PN2TqF7mywsldtZ/1r+qhAFjnHWy5d5K9e9jGU+IoYRUIj3HuzIEbmujFw4NtvAAa
	 9zB7ARDDYylKUH0hna69orBn5qin2E/UaDci7PATib5CfeZcdiPX4C1ouP8gmEzgiZ
	 bEL0fMJ62GXrGkiViEihf9T3EI7WIYlJxOVM1kq6vzdO+4Xhz4lwxsf6Z5/CP+xkBb
	 w6Xo3K06b0bw2A69f73unc7GtDhOwaVjBAtr72KCU3Whxo2JS3ddEKscgQyBJlxgLe
	 9M0aQErBMRi4faekAGL8Sl+w0xi7yfXmzw8nsf+dbNyAhxd15oXYDDlR7mi/FEKZhX
	 eBfh0Wm+LGOXg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] DAMON sysfs: failed update clears tried_regions snapshot
Date: Thu, 15 Oct 2026 18:26:21 -0700
Message-ID: <20261016012622.114496-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANOyQmHhCJEbHpHUZ2P0hui+We7wxWkEde-Vh4k2rRXWovRYrQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Aveline,


Please do not "top-post" [1].

On Thu, 15 Oct 2026 10:17:05 -0500 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> I haven't seen this affect a real workload. I found it while testing
> the DAMON sysfs interface.

You shared 4 bug reports in very short time.  Three of those are from 32 bit.
Could you disclose the purpose of the testing and how you are doing the
testing, finding bugs, and reporting those?

> 
> If a tool tries to refresh after monitoring stops, the failed request
> can delete the last snapshot. The tool then has no previous result to
> fall back to.

Why would the tool tries to refresh the regions after the monitoring is
stopped?

> 
> I built and tested 66178e4ec30a and its parent cce0b334c310 with the
> same config and reproducer. In three runs each, the parent kept the
> 4 MiB snapshot after rejecting the refresh; 66178e4ec30a cleared it.
> Both returned -EINVAL.

Is this an answer to my bisection question?

[1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying


Thanks,
SJ

[...]
