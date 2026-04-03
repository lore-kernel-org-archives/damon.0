Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9D2E173B
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225563; cv=none; b=HFwCR41mqIUAyIGcoIzYcGTrPfx46LfIKtt9mbdJss1JQY/Dws19kTTuzW1XwnTehmvFKh6u/1VrdIufGCh0ZCxiGU8KI3RvBJum6sPLvTLAJ5/seSG1j3U7YNwy1gg5af/fvetpoC2U2fJr2byf6kesT4SbmCImuuSvbeKVUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225563; c=relaxed/simple;
	bh=Wp0rUchgEfo3aH/vpLC2bON7hvYn0ruFcpGR7D1KSbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgyNfSq0Zz3e7ipBPvciyl0q6gCt8b3EBP5lSsczRTkMgT1l/eYXatWHU7Sygm/wBHZX7b1iUgSzdxAW6b9ugNNZc1wZsg59VfbiF+KK6AOzuHPZkHRS7b3EVOdeBjgByi+zXMpfho7NXGO/xyY0hjd7f0vdTiHmidOZxhr5ZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owPM0zQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owPM0zQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13583C4CEF7;
	Fri,  3 Apr 2026 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775225563;
	bh=Wp0rUchgEfo3aH/vpLC2bON7hvYn0ruFcpGR7D1KSbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owPM0zQQokQ22BSvz35J3xN2jUybaeYxIuZW0oHmducsrHIcOroyklEND2AJZw9sy
	 1zFg8l3G5oIsbSykmZNmyIrRSW6x+Ws9IIoerf0cXKFP3dtI/4c7gOtX9oMFMU8CDg
	 Z3DX+Jyz/T3YZKxyol4IKcVXrtbFGcRpRt3Wj0NSvFHdGXCBthD99a8hM/0+1WQhD8
	 naJRAAFL6ha+Ln/VW40ixEcDvWO6rCAnkgdyCL8ooUDEhwdU2IW1vy1HeWdvF8g5hH
	 L9zP9CVBrXTCBH49QfdzicHNKPD0bB/VZpy9WWFgEqcUa2vF4Wg5vf5985COZDgO89
	 LUNLU4/d9eJAQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 07:12:41 -0700
Message-ID: <20260403141241.50759-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403140942.50643-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  3 Apr 2026 07:09:41 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri,  3 Apr 2026 16:29:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Hi SeongJae,
> > 
> > Sorry for missing the discussion before sending out v3. I was too
> > focused on the code and missed the context of your questions.
> 
> No worries.  From next time, please ensure discussions on the last version is
> ended, by replying to questions and waiting about one day for giving others to
> chime in, before sending the next version.

Also, please don't rush.  Let's take enough time for both writing and reviewing
of the code.


Thanks,
SJ

> [...]
> 
> Thank you for all your answers to my questions and requests.  That all make
> sense to me.
> 
> > 
> > > 
> > > [...]
> > > 
> > > The code changes look good to me.
> > > 
> > > [1] https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com
> > 
> > Thank you for your review and patience.
> 
> You are always welcome.
> 
> > 
> > [1] https://lore.kernel.org/20260403052837.58063-1-aethernet65535@gmail.com
> 
> 
> Thanks,
> SJ
> 
> [...]
> 

Sent using hkml (https://github.com/sjp38/hackermail)
