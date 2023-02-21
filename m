Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB74C66
	for <damon@lists.linux.dev>; Tue, 21 Feb 2023 17:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC12C433D2;
	Tue, 21 Feb 2023 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676999993;
	bh=7wiQ/xYyuNw35RKFXPt2R11yI1JBADiHr0Pe0/cFFAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHAo4FtCP0Gb4wZWxmWcQnfhP6mXjTZ/hOEATZCBUT4xivBT+q2ywg1Qc4T//lg06
	 ndLpwV8tcONINacxKE7WYYBVPqp4EhSR0diinFg5Wu1wGQawbT5+329I3MnqNH5R3t
	 vatriqnFP7UkWzNBuXUMDtiOOmLtKSRdJ5prFRj8C2xEqrAoID8/2i4Ej+Ccez6yJv
	 3V8sHmFog3/wJqIJyFNRocSyOtpJ3rZPK8cvwjAx1Za+gRwIDbplRXeEHCJvlPJ86g
	 dHuhJ2wlkFQ0QUzEb0EZ2Lo00xafBWNmEOENedQHOhwmcuoOU0CbF1F8w0kY4AhPCA
	 j/yp9vPws5Xqw==
From: SeongJae Park <sj@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: sj@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 1/2] selftests: damon: add config file
Date: Tue, 21 Feb 2023 17:19:51 +0000
Message-Id: <20230221171951.131472-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221070837.1502935-1-anders.roxell@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anders,


Thank you for this patch!

On Tue, 21 Feb 2023 08:08:36 +0100 Anders Roxell <anders.roxell@linaro.org> wrote:

> Building and running the subsuite 'damon' of kselftest, shows the
> following issues:
>  selftests: damon: debugfs_attrs.sh
>   /sys/kernel/debug/damon not found
> 
> By creating a config file enabling DAMON fragments in the
> selftests/damon/ directory the tests pass.
> 

I think we could put Fixes tag as below?

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")

Though this may not need to be merged in stable.

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/damon/config | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 tools/testing/selftests/damon/config
> 
> diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
> new file mode 100644
> index 000000000000..a6b636e438b9
> --- /dev/null
> +++ b/tools/testing/selftests/damon/config
> @@ -0,0 +1,8 @@
> +CONFIG_DEBUG_SYSFS=y

's/SYS//'?  Or, I guess this is not needed at all?

> +CONFIG_DAMON=y
> +CONFIG_DAMON_SYSFS=y
> +CONFIG_DAMON_DBGFS=y
> +CONFIG_DAMON_PADDR=y
> +CONFIG_DAMON_VADDR=y
> +CONFIG_DAMON_RECLAIM=y
> +CONFIG_DAMON_LRU_SORT=y


Thanks,
SJ

> -- 
> 2.39.1
