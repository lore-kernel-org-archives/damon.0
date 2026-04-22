Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6871A6815;
	Wed, 22 Apr 2026 04:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776832520; cv=none; b=XkqBM0QePM3FhftHrdS7+PsKnwLwhBLjhnek679awbzAceI2myxIxDm457AZKgbKlS64vVDi6+E4ojWqanuHDIoVZFpf+n9KHVF+Xyb7JP9OaYB4TW+n0pOxa6AYtptyc6H/60UNUHHXTjIs+gCj1any3tlU+jCTEFDbzqBS1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776832520; c=relaxed/simple;
	bh=h7aRfzS42EkElr2GaVorlivQS4yQtChao6czjfMEwyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sy65Nx8vxjlNOH3Wkt1vDLA3CsT4tbm7VAWXZJjmq9dN7hQfapw40tUCHlGQm3Sooij337ztbOMxmV6WtgIT4vqC6gGf9VUA+fdNR9CbW+DJMFdZd+KRJkXncYXGYj5xSxZKHRBKQX8/HHroN2ZwWSht5CRViVR1n+mlPmkRLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7iEnDsY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7iEnDsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF2C19425;
	Wed, 22 Apr 2026 04:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776832519;
	bh=h7aRfzS42EkElr2GaVorlivQS4yQtChao6czjfMEwyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7iEnDsY5RMSecQ3rEatP4xUzPb3pPMYWcFK5FCe4RN7KROzBL4cqfOK3p7jZ11/4
	 mnLufX3fl7Aa49dvZQiCvypuvlb3kg66ac68fvgh3rw+PM0aAE4moMGuDNVkIEJ5wn
	 SKpC+va594fXdXnwu36qGNe0G9QI9+5ZmnbCSZyIXbQJ6S6KAF1fRCm8e7cosExI2x
	 HWBH0uftBp8YOvSfTsdmpWIZdYwu/SJqwYKoGpQ82smB0dKiC/Cnsqv4sF3CaDSQvx
	 c7RXLWmTJXcJd4diCTWhjUZAokEbHOEc5jerjNHTXTbKpQum7GPkg9nKPiKLhDOHsi
	 UiEJdv7fitWsA==
From: SeongJae Park <sj@kernel.org>
To: junxi qian <qjx1298677004@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path
Date: Tue, 21 Apr 2026 21:35:09 -0700
Message-ID: <20260422043509.66755-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAkLyHRCUS7=YEQRrLyRXX5X10pHDGA1e2gnKQsLvGkcqUy2Ng@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Apr 2026 12:31:43 +0800 junxi qian <qjx1298677004@gmail.com> wrote:

> Hi SJ,
> 
> Thank you for the suggestion and for offering to help.

My pleasure!

> 
> It would be great if you could finish the remaining work. Please feel
> free to add my Co-developed-by: and Signed-off-by: tags.

Ok, I will.


Thanks,
SJ

[...]
