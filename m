Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34D353A6E;
	Wed, 22 Jul 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728097; cv=none; b=C6TXx7RLJUW4BEgPoa5AvAaSqyCdr8dz/oDv/syw9hA9ZuHxXX6WjynRp+/aJmrzgFJP8/jft1bDS+E0KSQOgq/pslFooGde4/FcYHkP18dW7489cKKVGUHPp/zhOqv4s1NvK6eY/zj0JjvkAGOmB1koc3leGtmLNXkTv2asp58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728097; c=relaxed/simple;
	bh=va6jY1AWHfeG8Ua4zvyOd7tvNlFcjrrw+odERJn9+h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGSD4z17jiW1x23rv0jJXI5CHrLuiLw/uTk2nRoJp1I4L0udQKb9iQ9U6jIb0BII0OMgsieZxcOpdawSGvk97TjloeRIw8KJYE5Er7SB790V7oCWG/M06Qec3bVbnv0dQhKXCfnvY+7ulMllM3xtnxixt+z0HO67ufupfK8mmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihF369TR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihF369TR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728161F00A3A;
	Wed, 22 Jul 2026 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728095;
	bh=hqr52O01QL+8rXNjOIialVzyWEy2PL3xs2YZI1bEPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ihF369TR/bVoyo4aQ4voUjIhvMp+kJdM2NbFjPI1N2Y1M1Py8Z3uq/lL7/c3XjN44
	 q1bCRhwgo4SIm6wtaFjlgc51+qHs0UWfCggqAvGi9PZkLfaF7uod/UJR+tWB+o/TSf
	 1gjg9Nlmc7eYMx6bPli/E4tGYSECBXUcG+M0bhJL5omH/aEhvTLFOXzNaV1j2UM71i
	 so/EwXeZiMaYJbaECrfRSiJaFl0VRWAqjyZLhrcBhazpROxKZ5J8eG85o+xhKDYvay
	 VJELNGidvBpI4Bx926JGTDoE0WStjicUuyIGffziGn45uTUanJbppeSEXQBbWkYlcA
	 DpW1ItKv1m4qQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Hari Mishal <harimishal1@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon/sysfs.py: clean up sh processes used for obsolete_target test
Date: Wed, 22 Jul 2026 06:48:12 -0700
Message-ID: <20260722134812.88133-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722033844.65932-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Jul 2026 20:38:43 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> This patch is applied to damon/next [2] tree.  If this patch is not added to
> mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
> to pick this.  So, no action from your side is needed for now.  If it seems I
> also forgot doing that or you cannot wait for my action, please feel free to
> directly ask that to Andrew.


We (mm community) now want to focus on making mm.git more stabilized and
therefore ready for the next merge window, rather than adding more changes that
are not really urgent.  I agree and want to help [1] that.  For the reason,
unless Andre pick this first, I will request adding this to mm.git only after
next -rc1 release.  Let me know if you think this is really urgent.

[1] https://lore.kernel.org/20260722133829.87607-1-sj@kernel.org


Thanks,
SJ
