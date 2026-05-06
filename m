Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C84ADDA6;
	Wed,  6 May 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087328; cv=none; b=bY11MRWHchd9j4h+1QhagAR/tnd6MWhKjO1ZlNtnqVWAI6nPeAupLKhDNe9fTZRcD7yeOzUGdoqcH2VBlWQM8rWTKMDhsPIAj7oYK8rBdpY/G5rZGXK6dc6JgNrbVnZe9qUBA/C47luXvuOSE1fj1I4aau22BofQ27r5r79P4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087328; c=relaxed/simple;
	bh=OinfjCEBW9A/zEcVntYLmeTMVufnD9W2gbv4xH5bO3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBklgrLCOV7H9KsHliwFdN+SEi87VpFO9CRwxsCv4D69Htkh2x2kat2Cssm+2P9D7Ws31bPvHzNxHqjAIAy0jaIdPXVykVmycEFKBoHwPs169YQqbFZ3+0yGSYAjQ39wphC3Frab+PCufzRlnORmJJviYQyoXVgAk/szL+9l37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt7vj2IA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt7vj2IA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6C4C2BCB0;
	Wed,  6 May 2026 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087325;
	bh=OinfjCEBW9A/zEcVntYLmeTMVufnD9W2gbv4xH5bO3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lt7vj2IA+WpEvC0ZhjqIJ0A2V6gsUo8oquR3lYInImLJcrPRK1aO5F5mdSnprtNOv
	 8j2AsQjUDQvwXnWaXp/ecedUh+kX0Xq3o35LRkV1n+3On6q4OiSkFi3Vs8pULtOFjo
	 vENrnUy3lfVM223S+y/W5HdHgEd7GOzIcGmCaB1BaLuEkBsAbsuq/X122JqmkVtcC4
	 jWk+zmZqRPKEP3kLNfldshCkLMEh0ar4AxnJFduRatzgHc7DJMNIiCppTsFe51ICjM
	 2cPHpqA/Gifc6iFTZxDc1q8HgNyeFoqmGidxrtn1NI/SSSMctMspP0PHXN7MzuCzFC
	 3jCY/58CkB/Yw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing NUMA hinting faults or alternatives to DAMON
Date: Wed,  6 May 2026 10:08:39 -0700
Message-ID: <20260506170840.10882-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218054320.4570-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


Slides for this topic is available at [1].

[1] https://lore.kernel.org/linux-mm/20260504070208.7106-1-sj@kernel.org/


Thanks,
SJ

[...]
