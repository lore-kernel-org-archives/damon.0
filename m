Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F4DF6B
	for <damon@lists.linux.dev>; Mon,  6 Nov 2023 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/J1Ta1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4237C433C7;
	Mon,  6 Nov 2023 23:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699314678;
	bh=ug7V1tbLRIildaS+c6ipgNYbpP3MEP1leM3HDA/pNkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/J1Ta1DDq5rM2T0i0r2i8ySnmYDnynAyI8MgLPEtC83Sc1yqctCBvAM7mV58yjpV
	 XAlZcJOR/lZ0+6KLOLaVgfnoH849vWznNg2tLTK8OpJJ8c4fSpX6dSNyVIH4BoFJ56
	 Z8dZb0HzliYqJH3ScFvBR7mCPYAbw9GldSFgHbJ46E1jCkLxw77XQXpkP6XUDA7d5a
	 c1MjSrTqnkRAr9syYUW3CtFskcFDtKzAGC49s39p1nhOFbTQqNK6zQorbxSPAgj9Tp
	 CFxYonO+6HMVOF0L1d0a3xpRF7g0uhces3+/XJugNe71DetWe/QMl9ViY4Mmmutupj
	 oJfmMudJysf1w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/damon/sysfs: fix unhandled return values
Date: Mon,  6 Nov 2023 23:51:16 +0000
Message-Id: <20231106235116.95842-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106233408.51159-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 6 Nov 2023 23:34:05 +0000 SeongJae Park <sj@kernel.org> wrote:

> Some of DAMON sysfs interface code is not handling return values from
> some functions.  As a result, confusing user input handling or
> NULL-dereference is possible.  Check those properly.
> 
> Please note that these patches are not cleanly applicable on mm-unstable
> since mm-unstable has dropped the mainline-merged patches and rebased on
> v6.6, while some DAMON patches that these patches are depend on are
> merged in the mainline after v6.6.  I confirmed these patches can
> cleanly applied on latest mainline, or mm-stable-2023-11-01-14-33.

I just checked mm-unstable has just updated, and confirmed these patches can
cleanly applied.


Thanks,
SJ

[...]
