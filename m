Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2003BF66E;
	Thu, 14 May 2026 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792158; cv=none; b=NwnXNgILzqLbncp7zBhptw7dHeL3P3JD8HaBuD+j9lEx58yplWz7K1BEjoh/7bxrjlfA8+LeV5nEkMgyX1GQGOOiicAEDC9kw9jDfw1BKwzOyZW76Mz3Bra6AdIgV6sYktxKD5r4/CXAyFdhKaDXOi53Z8rH+3llASv51ktY9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792158; c=relaxed/simple;
	bh=hQ6U9AAqO2NDnUhISzMYPhoRd0okxRTUe/Q/wyGQtqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJ08NKZM8pVS9z7oEibezKf92lH+KgO7ICrY9w3x3BiX5B3Fc+evQE7LDYtPeO/QCT590KmpTHCOER/pksl3jHr8rlapwoHvk8JNB+IAqqF7EdIzREGX67+OdEf4SlEIfByvd/vTVVg59KZCiZoAq4kKJW/hySYKTxVp/Y7YAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKD9yZyu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKD9yZyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D75C2BCB3;
	Thu, 14 May 2026 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792157;
	bh=hQ6U9AAqO2NDnUhISzMYPhoRd0okxRTUe/Q/wyGQtqo=;
	h=From:To:Cc:Subject:Date:From;
	b=pKD9yZyuPH1P10rmNWm4fj3vcRcgVPZuiBtYj1nBUYxK2lt13Q+BW6syJ1VOG6bUU
	 vyed2I0pRNjB9kNLRiw8/25WuGZsNeSZALs8/dlxLz0JZD8lJb2a0aMdwxd3v0Gryo
	 ehovRv9o9AwXcXm7ZRa4UU8YbMWiONT2ObNxQgBfhuvoqocZZIcssSavts7wmu5uAc
	 k3r4PM0l7tU8ur1UvQm4LkRPzgLIUVPphEhcNQ+nGWEilpR7kMMQrRN2T2cUIVyMeI
	 llQVFGhJcujD9iWWv92idEZ6JTElOa95fb4eewHlEmx/unwG31oVP7BQzLTbu3PeAE
	 aAQKUCRoj5U8Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	damon@lists.linux.dev
Subject: When Sashiko updates baselines?
Date: Thu, 14 May 2026 13:55:55 -0700
Message-ID: <20260514205555.51653-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


I posted my patch series [1] after rebasing to the latest mm-new
(0cec77cfd5314c0b3b03530abe1a4b32e991f639).  And Sashiko smartly tried to apply
it on the mm-new, but an older version of the mm-new
(7505bb13a9bb1f214310915ccc06643119fdafc9), and therefore failed [2].

I could rebase my series on the older version of mm-new and repost, but
wondering if Sashiko will use the lateset mm-new for the new version and fail
again.  Is there a way to predict what baseline Sashiko will use, or give a
hint [3]?

[1] https://sashiko.dev/#/patchset/20260514140904.119781-1-sj%40kernel.org
[2] https://sashiko.dev/#/log/baseline/20264/2
[3] https://lore.kernel.org/sashiko/20260426204746.93567-1-sj@kernel.org/


Thanks,
SJ
