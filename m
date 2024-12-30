Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8FEAD0
	for <damon@lists.linux.dev>; Mon, 30 Dec 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583723; cv=none; b=SY/NEKInnknAQ3Tv/0ADAxlE4GVVrTgBxcp/cbSrOEnLMwZK4aQOBg2wtdfe9uopHtYw9JOjPIRti1le99MNFZXrvNkbPOTV03RBQuQvLX/KaePibBmfAIYGB9n+oZfFZTszETb7fdvhwPaM/NxwkVCmvizsqXjliRkuH1vSQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583723; c=relaxed/simple;
	bh=V1GEgquyIaAqqLyj+VqQ5nz1ImeQLU+E1QFBK01R4Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uYRnbLpIuqlxPcV6Tkm6ZGmrzOOT/47t5k+5ZXdklTNBhKzYOSF8wsNLRt5xr58lT398GYQ5I3J3YK0LDk7su6FtIPNxawxewg52xuqGnLv39t+y2BeDJo2gJh5lq4bwMDh9X4+Ujz/5HKRevUoXmu7rhjmNTFOdIi2EL0J5RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+1l4sWV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+1l4sWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E766C4CED0;
	Mon, 30 Dec 2024 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583722;
	bh=V1GEgquyIaAqqLyj+VqQ5nz1ImeQLU+E1QFBK01R4Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+1l4sWVjYMC7WGzPsPaSf5NbvRmD5JX/ijWx0jYj89nSPtuql1pTB0uFCfZyRkbA
	 +IXeH3ueoO1jUFo6zlv64pLIthpkj+zVA821OQ+TQSmHo4UwaAI+7dZwM0krRU+HxI
	 mf3XkhErH1jortif4BbPDlZJvDb7iQeVYVJqtymUd/fk3rt4lbg6SK+grIgvOcw5ko
	 54YpTBjA7c1XgmPJszZz26kzKtqGBzcWDO98UqGeYbSYFKP6ty/QKDos8CIdJjo0mb
	 jwV+e5htPxhlix0TpEbFFa4ZEoXfpSAT/XZVwVP9gdOnZxzMRIiZ5iVkqizOZJPQ93
	 IyEgBqCxYJSmQ==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH damo] _damo_records: support address range in hex format
Date: Mon, 30 Dec 2024 10:35:18 -0800
Message-Id: <20241230183518.14452-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241230134221.166041-2-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Dec 2024 22:42:21 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> In preparation for changing the display format of address ranges in
> tracepoints for DAMON, if the start and end addresses of an address range
> have a "0x" prefix, convert them as hexadecimal numbers.

Thank you for this patch.  However, I'm not yet convinced to the DAMON side
change.  Let's discuss this change after a discussion on the DAMON change is
finished.


Thanks,
SJ

[...]
