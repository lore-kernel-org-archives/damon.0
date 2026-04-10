Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77107A59
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863500; cv=none; b=TtZ++aXso8iNmGsCxlr9V6lEl3SNEntPM5RS6LzDwFxcVJadHRBOcpJwCRj/Ddr+qhckVW8jc5GAhncBCa0PlZWlX+0DKoicBuHDww/tGi2TrQMIh+2Ak+oiqWwpqXzQ6xa3Vf1DRhDui9eEWgacBMmpifBjlgiWxIC1DD1VrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863500; c=relaxed/simple;
	bh=+IalQQSVLkm1NicZsSzlRzKKA9cFbUHRWgUtOU/SLp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHbOcPkdmfmlTpxbgPv9sGvsJ8Fc6UlNz79/wI0P8nZJV/F0NlRfKukV+5Hx9lKTZKLcYjQ67XkU8gZu2GcsQZIHqsENeAzNMMSx6NH1kBXTC2Njug0IePLp0xKHf2aBOWIXZ3Ha781bO/syxZtdFcTjfSMB6hY1qKWs4ndmnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tECCPCUD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tECCPCUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DEEC19421;
	Fri, 10 Apr 2026 23:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775863500;
	bh=+IalQQSVLkm1NicZsSzlRzKKA9cFbUHRWgUtOU/SLp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tECCPCUDu/ZmHhakEQ6hhGRJWmxkPzaVYhali8b7i36NqVoBpuFeVLRHsGIsJeSXp
	 o4NzkSzntIR8ukU7vJrbOzmGkT9s3gJFX0Gt6k5OINQnrUsOwijD50QfV/dVVoLVDd
	 ZM95nTJC1JmA6oiaENdVSlaqq5ucQ0mlZAceuLh6XM2K6XCww+m7ubXkWd5i5pVNQn
	 oUYLniSl9Mj5YLy7k5wy4Bhu35qFz9TWiUPVhrF/tOq6PRnx7MR482rulIIpckfYG6
	 WkCMlh396rkcIFT8w5V3mPhEosgEus+osmMYG8D0Ae92AtDiVQ7RXJsNh1r0YpUZ/K
	 8rpi8wikQk32w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 16:24:52 -0700
Message-ID: <20260410232452.88060-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410170051.51008-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Fri, 10 Apr 2026 10:00:50 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> 1. Let's hold this patch series.  Andrew, please don't merge this for now until
>    this discussion is completed.

For this.


Thanks,
SJ

[...]
