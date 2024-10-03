Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1D8BF0;
	Thu,  3 Oct 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979947; cv=none; b=RyG9Z1wpD8Z7FqbhvRlpGNTmhcysMYMbQhBXNui64Pq8LkzoRLQna2eJkLnYhY/6I9VPBinhmoUK2m8qmUJlk8YFXfZzGCrORMa5ldU3Ul9h2q1hwbbd3yaYAIPWDiYndZtpndoIYY31vbap0mgkRWQLz3Mbn8UmltVzBT5fx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979947; c=relaxed/simple;
	bh=1RQTQfqzQYyIHZWAuqX1DmxIhKDqELflCG0wChfYsis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RiA4QJ69H/pqrVLn0KEUgHQxfGZ6V5k8SHsBC3NvahgovkrvFGdkPJ683fX/VsVWW3Baf32vWhu2K6wYJJpcWz53wQEmY22OE5Jjhq4e3j7TutrB2sVTz7kO2bRzbrkw8McPcHdzjl6NeezXfebEfo2jrloqy9RbYU2ei3596xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOeHKNB4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOeHKNB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8288C4CEC5;
	Thu,  3 Oct 2024 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727979946;
	bh=1RQTQfqzQYyIHZWAuqX1DmxIhKDqELflCG0wChfYsis=;
	h=From:To:Cc:Subject:Date:From;
	b=HOeHKNB4zkuyk7F+U7JBOvJ380Hp7hVQvZvDmMMGYI/il6RGQBru5O4iX+8swf22w
	 ZtfXSLwupmV8pI+6A63MZdcx6G1pa4IHaPhEt9QVpMO+i1Rg0ZkyU/31p+mH1m63lo
	 sTgT5Rc7tiYkBn+dvVlqVWf1uTu+/d2lQlYpPua8nXYfQsmiiHCBVzudZiQHEoVxHG
	 FLJ5kWZfDZVSvapyczyFFhI2jvUlrtQ0+gbWg631oscofiMx6+v3hDIra8guaXx98z
	 xACWrsSbDXpYkLb99A3cAm/1l864+0ImDB2v0agDPbS0caeGRiFxWMXhXhjuf+Xc68
	 T+HCMbExwejpw==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [DAMON Beer/Coffee/Tea Chat] Re-scheduling Tuesday instances to Wednesday
Date: Thu,  3 Oct 2024 11:25:43 -0700
Message-Id: <20241003182543.66235-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sj@kernel.org

Hello DAMON community,


We're currently having the bi-weekly DAMON Beer/Coffee/Tea chat series [1] on
Monday 6 PM and Tuesday 9:30 AM in Pacific Time of relevant weeks.  Due to a
conflict, moving all upcoming Tuesday instances to same time on Wednesday.  The 
Google doc [2] and shared calendar [3] for the meeting are also updated for the
change.

Thank you for your understanding of the change.  Please note that you can
whenever ask reschedules or additional meetings on your needs, though.

[1] https://lore.kernel.org/20220810225102.124459-1-sj@kernel.org
[2] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
[3] https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t


Thanks,
SJ
