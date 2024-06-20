Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697159167;
	Thu, 20 Jun 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921022; cv=none; b=nSd47Jo9k8BaG6m7elGhjumnuuz86/USkdpUoEYy/WPhPSL690t0VwEd8xi9wfp3rpyueEmbF78xImTICDOsz/1USvHj0/kn//1pdaEhl/nTZNfZf1vC5o2snVvl68RzogNRCSKRRwPdEWt1YJCVPXKbJI4tufIptP0sLl2yx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921022; c=relaxed/simple;
	bh=4kkMFcn9bF6FP/+A/ZmXnDJgTS3+aPVEfzbHol+5JB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tD8kk984BnPMvnswa/bIeUWmFOHsvZxozZqhVvNZYGncMPFBUjZn7RAcE0AvwVwE5SoqNWJeNkDT7So2mScTTvn9SJYxVslNJoWqkuDsZ/vmJkXKsWLPZsg+8LvUZyLtGg4yyZ0UeQioub8iUy/d0DeRQ1CxrItYzyy6+/U7MIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKJFujdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKJFujdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F68C2BD10;
	Thu, 20 Jun 2024 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718921021;
	bh=4kkMFcn9bF6FP/+A/ZmXnDJgTS3+aPVEfzbHol+5JB0=;
	h=From:To:Cc:Subject:Date:From;
	b=fKJFujdSJC8U0nmN8co4XDJ5je3ieKIFqbh8GOJJzNUsg2WZHrcddvzimAB0wZo4n
	 6hcasHNTFc/QuyogqzbXOLzeB02VitdJvCbYNqX0Ud/cilW5eJ4WF008yOQaJbElkV
	 bk/QwWvgHfuaO7bSQLUhdMgkQYrBDDQtFBPT/KyojzwuDxSD5uuw/ClWS2PevmYUNH
	 AqUXufLAHfHkxl3hfeY9IMsCO8VndQ8UPp7+KtPUPVEPhdZ97RMaHR3gL1Civ5nBN3
	 QFEefKhAOiCe1HniE3pgsIaLo4qGExoyFlox91ROxmo8D+6pIgMRbDR5quwEtAejBQ
	 kPsr39q9Orp7w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Docs/damon/maintaier-profile: document a mailing tool and community meetup series
Date: Thu, 20 Jun 2024 15:03:35 -0700
Message-Id: <20240620220337.76942-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a mailing tool that developed and maintained by DAMON
maintainer aiming to support DAMON community.  Also there are DAMON
community meetup series.  Both are known to have rooms of improvements
in terms of their visibility.  Document those on the maintainer's
profile document.

SeongJae Park (2):
  Docs/mm/damon/maintainer-profile: introduce HacKerMaiL
  Docs/mm/damon/maintainer-profile: document DAMON community meetups

 Documentation/mm/damon/maintainer-profile.rst | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)


base-commit: 22077d9caaee23160745d3794c2b0956efe2ebd6
-- 
2.39.2

