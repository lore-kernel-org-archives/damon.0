Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAF175A99;
	Sat, 28 Feb 2026 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318734; cv=none; b=F3Mll3qjizUGiYToqM58zQa1O6M3HeTM2T/9JA5AOW/ZiwiTN8MW9qwdBBqCzxK/DqWtf9m2sA3kRqLMprpHggHu0zc6wXhXjn9UbJdpj7VN+Z2esYeGCGZqx+WEG5MUUFZ4tg8eOvs0a75oQc+BJ2ZLlTkba72XP+LTG8UgAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318734; c=relaxed/simple;
	bh=tSTLV3hh0zdv4JdwDyNz6FB+mBuMYydTeNeT2mIVrBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeBpAUQGAi5P6CQp1pFrx+xeiCZquRwDW6G2vZbqjt8vfJhrkIi4tAKH11DKB7Es5liNTAyQhjmzm1daTfHKOkSjXYapEzTNcfWcFcuiSt/6ynC8Cg3WfpUyUMdnlR6q4mQz/m78mNiNPejh8eRJWD8dsHcI2pFOOsT1cIk6CNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAD9+Ez6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAD9+Ez6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AACC116D0;
	Sat, 28 Feb 2026 22:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772318733;
	bh=tSTLV3hh0zdv4JdwDyNz6FB+mBuMYydTeNeT2mIVrBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAD9+Ez6erx7g95bkAj/O5d0ktZTq9tPGlqYkn2ljspqeuoRSB/xkVHZaFueltGZ4
	 QmfMDJ7tX83uzZdTYdoStfoazP9ixr9pj8FboVLQBQRNw4YfvrPVqut/WRXrOZ71wH
	 L8KyQKtrk553lW2VwkZ3zMGaFy955dNUl8K6GoqkN+Sjm3SgpNM7m74vwcAFp3HI1D
	 Jt+PtCr4MklVsSvfzjmzpORMQZy9Cnf1ziroX1Q2Rb2GEcg2Xpc2YggRNfi90i3NiC
	 QEspVcMLsr4vqi62QlsdKQiwhMPDzlUKhtcb6FzDljaVTty3vchqLQNpfUIQxGmBzh
	 Sr0/UofGmgqWg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 10/10] tools/testing/selftests/damon/config: enable DAMON_DEBUG_SANITY
Date: Sat, 28 Feb 2026 14:45:24 -0800
Message-ID: <20260228224525.8345-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-11-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more common to use 'selftests/damon' as the prefix of DAMON selftests
patches.  I will do so in the next revision.


Thanks,
SJ

[...]
