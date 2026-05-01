Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26A23EAAD;
	Fri,  1 May 2026 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600569; cv=none; b=PN1vzj/1JjW+cPayweTpJQr5jTqj8c8T0FOFijaJsXvTANh+nf//O4+GgPb8NO3IlZ5C6UzwoldSGdG2BZjhv6YGGnxVDYU7EL5EM4AAZoc7fwJqYYyq2RPEDZXf2SAIo5oB1/2VhzpBkYKZf0ll0bnN9o4aHkeL0t/jKJTi5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600569; c=relaxed/simple;
	bh=qzviNm8rnhp1c0NC3tvj7ydyyrxohLehCvxK6danluE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQm2L3gDEoWcZtbY1YLvwzyay93KHlwa8L7wVB26XpgySdvBvTzeI4T828Nxcrenm1PRPY/ZMT67w+IJ2hy/3uAu2UJLNNAIm/2FwJCj1P8RYJqv6huL3rT8hG21MHMTNfuYWgp+PQYny3dC0JVvIdwunTnwdaapsnKgOHHHjRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFjIjmRL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFjIjmRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DEBC2BCB3;
	Fri,  1 May 2026 01:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777600568;
	bh=qzviNm8rnhp1c0NC3tvj7ydyyrxohLehCvxK6danluE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFjIjmRLHJwtVZaHIAzcwOOFWelAi76TY8UEznldmWeAh+LSB2QMEyWImvw1GhK49
	 jUnJjSMDGpR8zaZkSNB/YMvABpAj6pJRjUt4uR5T0QdyYaWsBHKSFXpwjDF+OWJdcq
	 NdEGrMZU9DS0eC7wsE8RwU2R9VLoqqM46MYuMLwrpkt69iKQR0CAXZHBZRirUVery0
	 P+bjyt07fat5KFz1lQlbYSMzvJg4o8tQgq8U4AQUgDBofrvv3qtykX9LwH1Dt03opA
	 ndFFQSZvm/9qJTnIdPXQ9+gSLKByzr5tMFxSE5+hjJ0IRLEWT7mixx2gB1ldj0grK6
	 MhnTEY9TNtcJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/11] mm/damon: introduce DAMOS failed region quota charge ratio
Date: Thu, 30 Apr 2026 18:56:04 -0700
Message-ID: <20260501015604.83041-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428152424.125760-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 08:24:24 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello Andrew,
> 
> On Tue, 28 Apr 2026 07:48:37 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Mon, 27 Apr 2026 18:33:49 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > TL; DR: Let users set different DAMOS quota charge ratios for DAMOS
> > > action failed regions, for deterministic and consistent DAMOS action
> > > progress.
> > 
> > Add, thanks.
> > 
> > As mentioned provately, Sashiko claims to have found things which it
> > didn't see in the RFC.
> > 
> > 	https://sashiko.dev/#/patchset/20260428013402.115171-1-sj@kernel.org
> 
> TL; DR: I find no blocker for this patch series from the Sashiko reviews.
> 
> Now sashiko replies its reviews for DAMON patches to authors and
> damon@lists.linux.dev.  So I replied [1,2,3] my review of the reviews to those
> on damon@lists.linux.dev mailing list.  As I mentioned on the TL;DR, I find no
> blocker for this series.
> 
> And I think you didn't see those because those are sent to only authors and
> damon@lists.linux.dev.
> 
> I nowadays reply-all to original recipients only if Sashiko found a blocker.  I
> will also add short notice for non-RFC patches if Sashiko found zero issue.

... Now I think the short notice is only redundant and silly, as the full
review is available on damon@ list and the one who primarily interested in
(Andrew) understands that.  I feel like the short-notice reply-all only
increase unnecessary traffic and my redundant typing.  I will not do the short
notice broadcasting, unless someone makes a diffeernt voice.


Thanks,
SJ

[...]
