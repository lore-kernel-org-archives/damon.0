Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89EF1DFE12;
	Fri, 27 Mar 2026 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774584566; cv=none; b=eTwnhihXYygjF4VXG7/QZ/YtkVwgNezmPY1QrLvtQ0wiKwmN8U3Z1aFhJS9spab9/N/3506pZO27kSy/VpMXCYbA0CKpVUlpvcSG0gyHjPYoQAWPDd/1GsO7ipW1DMwHJuUkOMQ3E7y8op+hcBtjirKOxje8oq+IphsdqiL9P0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774584566; c=relaxed/simple;
	bh=VhiGD6KtnZd+xe0epOwm1e6fUvTl6fwsBNoGmCIAQ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCDQAY9yc22zCAM1iaGAd5e5yXLyr3zvPW5LEb4r9No1n6KbMPZo4ZUHlo81TdaNzreB26FJXuY37RfYSlio8Bidyr/24FSCw6poRa/u3+veK4zVPx1zCNs0EwIqPvXrZDvUeDVmdzFKQnptrCZEsOowl5CAW+JWjYK6HSWdI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg11G2m3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg11G2m3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1604BC19423;
	Fri, 27 Mar 2026 04:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774584566;
	bh=VhiGD6KtnZd+xe0epOwm1e6fUvTl6fwsBNoGmCIAQ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kg11G2m3jFiAiPDkATGEvbbcHL/zJ2zmEQ5D2n636p3oUTUSnG/e1d+RpTdkfmaaA
	 NS7AoHYrQd91kVcExk9gziM+pdkx1QnoLNI9NGQN7v91P2pCn9qJxx4r6X2SMcdj0f
	 xv+7Pww3LMLKFqZU3CDaf75z3HJonQQGmtG687gLa/M2m3Whv1AZqKEmHt/tFKVt4r
	 Rltst+bTIfBA9LgrcB9XYoaKL7gLZ9btDXeMWu8j8jBHRSjPJSzA9TELRX39Fg1KR3
	 ExsXg7qkcfsDRS0VA1M6WEpQJnIOiTwRofA6VV6V7Bm33/KACoXMGodk1r+eokiWn6
	 fzXm3rEfsSclw==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Josh Law <hlcj1234567@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] mm/damon: introduce DAMON-based NUMA memory tiering module
Date: Thu, 26 Mar 2026 21:09:23 -0700
Message-ID: <20260327040924.68553-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <E1A667AB-DCE4-4034-A36B-DAA458780A81@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Mar 2026 16:39:54 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 26 March 2026 16:33:30 GMT, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:

Thank you for sharing your findings and inputs, Lorenzo and Krzysztof.

[...]
> I am withdrawing all pending patches, I am not gonna even touch artificial intelligence again, and I am going to take a couple months break

Also thank you for making it clear about what will happen next.

I understand Josh will stop working on mm, and therefore DAMON too, as DAMON is
a part of mm.

Among Josh's patches that are already posted and still in the review stage,
DAMOS quota goal nid validation patch [1] is a bug fix, so it may need more
look and work.  I will do that.

For other patches including this one, I don't think we really need to continue
the works.  So I will just skip reviewing those.

[1] https://lore.kernel.org/20260325155221.202700-1-objecting@objecting.org


Thanks,
SJ

[...]
